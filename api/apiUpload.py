from flask import *
from flask import url_for
from flask import send_file
from flask import jsonify


import sys
sys.path.append('/home/bybsongbird/app/bybsongbird')
import config

import extensions

import os
from machine_learning_and_dsp.process_and_categorize import classiFier
from waveform import Waveform
import json
from zlib import crc32
from flask import request



#App's api upload file. 



sys.path.append('/home/bybsongbird/app/bybsongbird/static/songs/users')

apiUpload = Blueprint('apiUpload', __name__, template_folder='templates')


@apiUpload.route('/apiUpload', methods = ['GET', 'POST'])
def apiUpload_route():
	
		

         	#basically copied and pastedd from ../controllers/upload.py. Difference is missing html rendering right here at the beginning and at end. See end for details. 
		files = request.files.getlist('file')
               
       	 	model_file = os.path.join(os.getcwd(), 'model2', 'model')
        	identify = classiFier(model_file=model_file, verbose=True)

        	matches = []
       		file_num = len(files)
       
                filename = secure_filename(file.filename)
                user_file_temp = os.path.join(config.env['UPLOAD_FOLDER'], filename)
                file.save(user_file_temp)

                with open(user_file_temp, 'rb') as file_contents:
                    sample_id = crc32(file_contents.read())

                filename = str(sample_id) + '.WAV'
                user_file = os.path.join(config.env['UPLOAD_FOLDER'], filename)
                os.rename(user_file_temp, user_file)

                result = identify.classFile(user_file, username=current_user.get_id())
                first_match_name = result["values"][8]
                first_match = [{"name": first_match_name[1:first_match_name.find('_')].title(), "value": float(result["values"][9])}, {"name": "Other", "value": 1 - float(result["values"][9])}]
                second_match_name = result["values"][10]
                second_match = [{"name": second_match_name[1:second_match_name.find('_')].title(), "value": float(result["values"][11])}, {"name": "Other", "value": 1 - float(result["values"][11])}]
                third_match_name = result["values"][12]
                third_match = [{"name": third_match_name[1:third_match_name.find('_')].title(), "value": float(result["values"][13])}, {"name": "Other", "value": 1 - float(result["values"][13])}]

                user_waveform = Waveform(user_file)
                user_waveform.save()
                user_waveform_file = user_file.replace(user_file.split('.')[-1], 'png').replace(os.getcwd(), '')
                user_file = user_file.replace(os.getcwd(), '..')

                activity_file = os.path.join(config.env['UPLOAD_FOLDER'], 'activity/' + filename)
                if os.path.isfile(activity_file):
                    activity_waveform = Waveform(activity_file)
                    activity_waveform.save()
                    activity_waveform_file = activity_file.replace(activity_file.split('.')[-1], 'png').replace(os.getcwd(), '')
                    activity_file = activity_file.replace(os.getcwd(), '..')
                else:
                    activity_waveform_file = None
                    activity_file = None

                noise_file = os.path.join(config.env['UPLOAD_FOLDER'], 'noise/' + filename)
                if os.path.isfile(noise_file):
                    noise_waveform = Waveform(noise_file)
                    noise_waveform.save()
                    noise_waveform_file = noise_file.replace(noise_file.split('.')[-1], 'png').replace(os.getcwd(), '')
                    noise_file = noise_file.replace(os.getcwd(), '..')
                else:
                    noise_waveform_file = None
                    noise_file = None

                user_clean_file = os.path.join(config.env['UPLOAD_FOLDER'], 'users_clean/' + filename)
                if os.path.isfile(user_clean_file):
                    user_clean_waveform = Waveform(user_clean_file)
                    user_clean_waveform.save()
                    user_clean_waveform_file = user_clean_file.replace(user_clean_file.split('.')[-1], 'png').replace(os.getcwd(), '')
                    user_clean_file = user_clean_file.replace(os.getcwd(), '..')
                else:
                    user_clean_waveform_file = None
                    user_clean_file = None

                cur = db.cursor()
                cur.execute("SELECT * FROM sampleInfo WHERE sampleid = %s", (result['sample_id'], ))
                result_sample = cur.fetchall()
                latitude = result_sample[0]['latitude']
                longitude = result_sample[0]['longitude']
                humidity = result_sample[0]['humidity']
                temp = result_sample[0]['temp']
                if temp:
                    temp = int(round(temp))
                light = result_sample[0]['light']
                if light:
                    light = int(round(light))

                matches.append({
                                'user': user_waveform_file,
                                'filename': user_file,
                                'sample_id': result['sample_id'], 
                                'first_match': json.dumps(first_match),
                                'second_match': json.dumps(second_match),
                                'third_match': json.dumps(third_match),
                                'activity': activity_waveform_file,
                                'activity_audio': activity_file,
                                'noise': noise_waveform_file,
                                'noise_audio': noise_file,
                                'user_clean': user_clean_waveform_file,
                                'user_clean_audio': user_clean_file,
                                'file_num': file_num,
                                'latitude': latitude,
                                'longitude': longitude,
                                'humidity': humidity,
                                'temperature': temp,
                                'light': light
                                })
        
        	options = {
        	    'matches': matches,
        	}
		#difference here. Instead of return html, returns file. 
		return jsonify(options)
