#! python


import getopt
import os
import sys
import time

from noise_removal import noiseCleaner
from sanitize_filenames import sanatize_filenames
from test_model import tester
from twillio_test import send_notification


def test_params(dir, categories):
    test_dirs = []
    for cat in categories:
        test_dirs.append(os.path.join(dir, cat, '_'.join([cat, 'clean'])))

    return test_dirs


def clean_and_test(directory, model_file, classifierType, birds, verbose, skip_clean, no_sanitize):
    if not len(birds):
        raise Exception("Must specify at least one folder/category to test!")

    start_time = time.clock()

    # birds = ['bluejay_all', 'cardinal_all', 'cardinal_call', 'cardinal_song', 'chickadee_all', 'chickadee_call',
    # 'chickadee_song', 'crow_all', 'goldfinch_all', 'goldfinch_call', 'goldfinch_song', 'robin_all',
    # 'robin_call', 'robin_song', 'sparrow_all', 'sparrow_call',
    # 'sparrow_song', 'titmouse_all', 'titmouse_call', 'titmouse_song']

    test_dirs = test_params(directory, birds)

    try:
        if not no_sanitize:
            sanatize_filenames(directory, verbose=verbose)
        if not skip_clean:
            for dir in test_dirs:
                rootdir, subdir = os.path.split(dir)
                cleaner = noiseCleaner(verbose=verbose)
                cleaner.noise_removal_dir(rootdir)
        model_dir, model_name = os.path.split(model_file)
        if not len(model_dir):
            model_dir = os.getcwd()
        model_tester = tester(test_dirs, modelName=model_name, model_dir=model_dir, classifierType=classifierType,
                              verbose=verbose)
        model_tester.test_model()
    except Exception:
        send_notification("Clean and test process failed.")
        raise
    else:
        send_notification("Clean and test finished successfully.")
        print "Total time elapsed: ", time.clock() - start_time, " seconds."


if __name__ == '__main__':

    directory = os.getcwd()
    classifierType = 'gradientboosting'
    birds = []
    verbose = False
    model_file = os.path.join(directory, 'model')
    skip_clean = False
    no_sanitize = False

    try:
        opts, args = getopt.getopt(sys.argv[1:], "d:m:c:b:vsn",
                                   ["dir=", "model=", "classifier=", "bird=", "verbose", "skip-clean", "no-sanitize"])
    except getopt.GetoptError as err:
        # print help information and exit:
        print str(err)  # will print something like "option -a not recognized"
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-d", "--dir"):
            directory = arg
        elif opt in ("-m", "--model"):
            model_file = arg
        elif opt in ("-c", "--classifier"):
            classifierType = arg
        elif opt in ("-b", "--bird"):
            birds.append(arg)
        elif opt in ("-v", "--verbose"):
            verbose = True
        elif opt in ("-s", "--skip-clean"):
            skip_clean = True
        elif opt in ("-n", "--no-sanitize"):
            no_sanitize = True
        else:
            assert False, "unhandled option"

    if not os.path.isfile(model_file):
        raise Exception("Model file:" + model_file + " not found!")

    if classifierType not in ('knn', 'svm', 'gradientboosting', 'randomforest', 'extratrees'):
        raise Exception(classifierType + " is not a valid model type!")

    clean_and_test(directory, model_file, classifierType, birds, verbose=verbose, skip_clean=skip_clean,
                   no_sanitize=no_sanitize)
