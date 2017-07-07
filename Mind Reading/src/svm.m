function [trainedClassifier, validationAccuracy] = svm(trainingData)
% trainClassifier(trainingData)
%  returns a trained classifier and its validation accuracy.
%  This code recreates the classification model trained in
%  Classification Learner app.
%
%   Input:
%       trainingData: the training data of same data type as imported
%        in the app (table or matrix).
%
%   Output:
%       trainedClassifier: a struct containing the trained classifier.
%        The struct contains various fields with information about the
%        trained classifier.
%
%       trainedClassifier.predictFcn: a function to make predictions
%        on new data. It takes an input of the same form as this training
%        code (table or matrix) and returns predictions for the response.
%        If you supply a matrix, include only the predictors columns (or
%        rows).
%
%       validationAccuracy: a double containing the validation accuracy
%        score in percent. In the app, the History list displays this
%        overall accuracy score for each model.
%
%  Use the code to train the model with new data.
%  To retrain your classifier, call the function from the command line
%  with your original data or new data as the input argument trainingData.
%
%  For example, to retrain a classifier trained with the original data set
%  T, enter:
%    [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
%  To make predictions with the returned 'trainedClassifier' on new data T,
%  use
%    yfit = trainedClassifier.predictFcn(T)
%
%  To automate training the same classifier with new data, or to learn how
%  to programmatically train classifiers, examine the generated code.

% Auto-generated by MATLAB on 27-Jun-2017 13:21:15


% Convert input to table
inputTable = table(trainingData');
inputTable.Properties.VariableNames = {'row'};

% Split matrices in the input table into vectors
inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'row'})), array2table(table2array(inputTable(:,{'row'})), 'VariableNames', {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67', 'row_68', 'row_69', 'row_70', 'row_71', 'row_72', 'row_73', 'row_74', 'row_75', 'row_76', 'row_77', 'row_78', 'row_79', 'row_80', 'row_81', 'row_82', 'row_83', 'row_84', 'row_85', 'row_86', 'row_87', 'row_88', 'row_89', 'row_90', 'row_91', 'row_92', 'row_93', 'row_94', 'row_95', 'row_96', 'row_97', 'row_98', 'row_99', 'row_100', 'row_101', 'row_102', 'row_103', 'row_104', 'row_105', 'row_106', 'row_107', 'row_108', 'row_109', 'row_110', 'row_111', 'row_112', 'row_113', 'row_114', 'row_115', 'row_116', 'row_117', 'row_118', 'row_119', 'row_120', 'row_121', 'row_122', 'row_123', 'row_124', 'row_125', 'row_126', 'row_127', 'row_128', 'row_129', 'row_130', 'row_131', 'row_132', 'row_133', 'row_134', 'row_135', 'row_136', 'row_137', 'row_138', 'row_139', 'row_140', 'row_141', 'row_142', 'row_143', 'row_144', 'row_145', 'row_146', 'row_147', 'row_148', 'row_149', 'row_150', 'row_151', 'row_152', 'row_153', 'row_154', 'row_155', 'row_156', 'row_157', 'row_158', 'row_159', 'row_160', 'row_161', 'row_162', 'row_163', 'row_164', 'row_165', 'row_166', 'row_167', 'row_168', 'row_169', 'row_170', 'row_171', 'row_172', 'row_173', 'row_174', 'row_175', 'row_176', 'row_177', 'row_178', 'row_179', 'row_180', 'row_181', 'row_182', 'row_183', 'row_184', 'row_185', 'row_186', 'row_187', 'row_188', 'row_189', 'row_190', 'row_191', 'row_192', 'row_193', 'row_194', 'row_195', 'row_196', 'row_197', 'row_198', 'row_199', 'row_200', 'row_201', 'row_202', 'row_203', 'row_204', 'row_205', 'row_206', 'row_207', 'row_208', 'row_209', 'row_210', 'row_211', 'row_212', 'row_213', 'row_214', 'row_215', 'row_216', 'row_217', 'row_218', 'row_219', 'row_220', 'row_221', 'row_222', 'row_223', 'row_224', 'row_225', 'row_226', 'row_227', 'row_228', 'row_229', 'row_230', 'row_231', 'row_232', 'row_233', 'row_234', 'row_235', 'row_236', 'row_237', 'row_238', 'row_239', 'row_240', 'row_241', 'row_242', 'row_243', 'row_244', 'row_245', 'row_246', 'row_247', 'row_248', 'row_249', 'row_250', 'row_251', 'row_252', 'row_253', 'row_254', 'row_255', 'row_256', 'row_257', 'row_258', 'row_259', 'row_260', 'row_261', 'row_262', 'row_263', 'row_264', 'row_265', 'row_266', 'row_267', 'row_268', 'row_269', 'row_270', 'row_271', 'row_272', 'row_273', 'row_274', 'row_275', 'row_276', 'row_277', 'row_278', 'row_279', 'row_280', 'row_281', 'row_282', 'row_283', 'row_284', 'row_285', 'row_286', 'row_287', 'row_288', 'row_289', 'row_290', 'row_291', 'row_292', 'row_293', 'row_294', 'row_295', 'row_296', 'row_297', 'row_298', 'row_299', 'row_300', 'row_301', 'row_302', 'row_303', 'row_304', 'row_305', 'row_306', 'row_307', 'row_308', 'row_309', 'row_310', 'row_311', 'row_312', 'row_313', 'row_314', 'row_315', 'row_316'})];

% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
predictorNames = {'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67', 'row_68', 'row_69', 'row_70', 'row_71', 'row_72', 'row_73', 'row_74', 'row_75', 'row_76', 'row_77', 'row_78', 'row_79', 'row_80', 'row_81', 'row_82', 'row_83', 'row_84', 'row_85', 'row_86', 'row_87', 'row_88', 'row_89', 'row_90', 'row_91', 'row_92', 'row_93', 'row_94', 'row_95', 'row_96', 'row_97', 'row_98', 'row_99', 'row_100', 'row_101', 'row_102', 'row_103', 'row_104', 'row_105', 'row_106', 'row_107', 'row_108', 'row_109', 'row_110', 'row_111', 'row_112', 'row_113', 'row_114', 'row_115', 'row_116', 'row_117', 'row_118', 'row_119', 'row_120', 'row_121', 'row_122', 'row_123', 'row_124', 'row_125', 'row_126', 'row_127', 'row_128', 'row_129', 'row_130', 'row_131', 'row_132', 'row_133', 'row_134', 'row_135', 'row_136', 'row_137', 'row_138', 'row_139', 'row_140', 'row_141', 'row_142', 'row_143', 'row_144', 'row_145', 'row_146', 'row_147', 'row_148', 'row_149', 'row_150', 'row_151', 'row_152', 'row_153', 'row_154', 'row_155', 'row_156', 'row_157', 'row_158', 'row_159', 'row_160', 'row_161', 'row_162', 'row_163', 'row_164', 'row_165', 'row_166', 'row_167', 'row_168', 'row_169', 'row_170', 'row_171', 'row_172', 'row_173', 'row_174', 'row_175', 'row_176', 'row_177', 'row_178', 'row_179', 'row_180', 'row_181', 'row_182', 'row_183', 'row_184', 'row_185', 'row_186', 'row_187', 'row_188', 'row_189', 'row_190', 'row_191', 'row_192', 'row_193', 'row_194', 'row_195', 'row_196', 'row_197', 'row_198', 'row_199', 'row_200', 'row_201', 'row_202', 'row_203', 'row_204', 'row_205', 'row_206', 'row_207', 'row_208', 'row_209', 'row_210', 'row_211', 'row_212', 'row_213', 'row_214', 'row_215', 'row_216', 'row_217', 'row_218', 'row_219', 'row_220', 'row_221', 'row_222', 'row_223', 'row_224', 'row_225', 'row_226', 'row_227', 'row_228', 'row_229', 'row_230', 'row_231', 'row_232', 'row_233', 'row_234', 'row_235', 'row_236', 'row_237', 'row_238', 'row_239', 'row_240', 'row_241', 'row_242', 'row_243', 'row_244', 'row_245', 'row_246', 'row_247', 'row_248', 'row_249', 'row_250', 'row_251', 'row_252', 'row_253', 'row_254', 'row_255', 'row_256', 'row_257', 'row_258', 'row_259', 'row_260', 'row_261', 'row_262', 'row_263', 'row_264', 'row_265', 'row_266', 'row_267', 'row_268', 'row_269', 'row_270', 'row_271', 'row_272', 'row_273', 'row_274', 'row_275', 'row_276', 'row_277', 'row_278', 'row_279', 'row_280', 'row_281', 'row_282', 'row_283', 'row_284', 'row_285', 'row_286', 'row_287', 'row_288', 'row_289', 'row_290', 'row_291', 'row_292', 'row_293', 'row_294', 'row_295', 'row_296', 'row_297', 'row_298', 'row_299', 'row_300', 'row_301', 'row_302', 'row_303', 'row_304', 'row_305', 'row_306', 'row_307', 'row_308', 'row_309', 'row_310', 'row_311', 'row_312', 'row_313', 'row_314', 'row_315', 'row_316'};
predictors = inputTable(:, predictorNames);
response = inputTable.row_1;

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 2, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone', ...
    'ClassNames', [1; 2; 3; 4; 5]);

trainedClassifier.ClassificationSVM = classificationSVM;
convertMatrixToTableFcn = @(x) table(x', 'VariableNames', {'row'});
splitMatricesInTableFcn = @(t) [t(:,setdiff(t.Properties.VariableNames, {'row'})), array2table(table2array(t(:,{'row'})), 'VariableNames', {'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67', 'row_68', 'row_69', 'row_70', 'row_71', 'row_72', 'row_73', 'row_74', 'row_75', 'row_76', 'row_77', 'row_78', 'row_79', 'row_80', 'row_81', 'row_82', 'row_83', 'row_84', 'row_85', 'row_86', 'row_87', 'row_88', 'row_89', 'row_90', 'row_91', 'row_92', 'row_93', 'row_94', 'row_95', 'row_96', 'row_97', 'row_98', 'row_99', 'row_100', 'row_101', 'row_102', 'row_103', 'row_104', 'row_105', 'row_106', 'row_107', 'row_108', 'row_109', 'row_110', 'row_111', 'row_112', 'row_113', 'row_114', 'row_115', 'row_116', 'row_117', 'row_118', 'row_119', 'row_120', 'row_121', 'row_122', 'row_123', 'row_124', 'row_125', 'row_126', 'row_127', 'row_128', 'row_129', 'row_130', 'row_131', 'row_132', 'row_133', 'row_134', 'row_135', 'row_136', 'row_137', 'row_138', 'row_139', 'row_140', 'row_141', 'row_142', 'row_143', 'row_144', 'row_145', 'row_146', 'row_147', 'row_148', 'row_149', 'row_150', 'row_151', 'row_152', 'row_153', 'row_154', 'row_155', 'row_156', 'row_157', 'row_158', 'row_159', 'row_160', 'row_161', 'row_162', 'row_163', 'row_164', 'row_165', 'row_166', 'row_167', 'row_168', 'row_169', 'row_170', 'row_171', 'row_172', 'row_173', 'row_174', 'row_175', 'row_176', 'row_177', 'row_178', 'row_179', 'row_180', 'row_181', 'row_182', 'row_183', 'row_184', 'row_185', 'row_186', 'row_187', 'row_188', 'row_189', 'row_190', 'row_191', 'row_192', 'row_193', 'row_194', 'row_195', 'row_196', 'row_197', 'row_198', 'row_199', 'row_200', 'row_201', 'row_202', 'row_203', 'row_204', 'row_205', 'row_206', 'row_207', 'row_208', 'row_209', 'row_210', 'row_211', 'row_212', 'row_213', 'row_214', 'row_215', 'row_216', 'row_217', 'row_218', 'row_219', 'row_220', 'row_221', 'row_222', 'row_223', 'row_224', 'row_225', 'row_226', 'row_227', 'row_228', 'row_229', 'row_230', 'row_231', 'row_232', 'row_233', 'row_234', 'row_235', 'row_236', 'row_237', 'row_238', 'row_239', 'row_240', 'row_241', 'row_242', 'row_243', 'row_244', 'row_245', 'row_246', 'row_247', 'row_248', 'row_249', 'row_250', 'row_251', 'row_252', 'row_253', 'row_254', 'row_255', 'row_256', 'row_257', 'row_258', 'row_259', 'row_260', 'row_261', 'row_262', 'row_263', 'row_264', 'row_265', 'row_266', 'row_267', 'row_268', 'row_269', 'row_270', 'row_271', 'row_272', 'row_273', 'row_274', 'row_275', 'row_276', 'row_277', 'row_278', 'row_279', 'row_280', 'row_281', 'row_282', 'row_283', 'row_284', 'row_285', 'row_286', 'row_287', 'row_288', 'row_289', 'row_290', 'row_291', 'row_292', 'row_293', 'row_294', 'row_295', 'row_296', 'row_297', 'row_298', 'row_299', 'row_300', 'row_301', 'row_302', 'row_303', 'row_304', 'row_305', 'row_306', 'row_307', 'row_308', 'row_309', 'row_310', 'row_311', 'row_312', 'row_313', 'row_314', 'row_315', 'row_316'})];
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(splitMatricesInTableFcn(convertMatrixToTableFcn(x)));
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));
% Convert input to table
inputTable = table(trainingData');
inputTable.Properties.VariableNames = {'row'};

% Split matrices in the input table into vectors
inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'row'})), array2table(table2array(inputTable(:,{'row'})), 'VariableNames', {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67', 'row_68', 'row_69', 'row_70', 'row_71', 'row_72', 'row_73', 'row_74', 'row_75', 'row_76', 'row_77', 'row_78', 'row_79', 'row_80', 'row_81', 'row_82', 'row_83', 'row_84', 'row_85', 'row_86', 'row_87', 'row_88', 'row_89', 'row_90', 'row_91', 'row_92', 'row_93', 'row_94', 'row_95', 'row_96', 'row_97', 'row_98', 'row_99', 'row_100', 'row_101', 'row_102', 'row_103', 'row_104', 'row_105', 'row_106', 'row_107', 'row_108', 'row_109', 'row_110', 'row_111', 'row_112', 'row_113', 'row_114', 'row_115', 'row_116', 'row_117', 'row_118', 'row_119', 'row_120', 'row_121', 'row_122', 'row_123', 'row_124', 'row_125', 'row_126', 'row_127', 'row_128', 'row_129', 'row_130', 'row_131', 'row_132', 'row_133', 'row_134', 'row_135', 'row_136', 'row_137', 'row_138', 'row_139', 'row_140', 'row_141', 'row_142', 'row_143', 'row_144', 'row_145', 'row_146', 'row_147', 'row_148', 'row_149', 'row_150', 'row_151', 'row_152', 'row_153', 'row_154', 'row_155', 'row_156', 'row_157', 'row_158', 'row_159', 'row_160', 'row_161', 'row_162', 'row_163', 'row_164', 'row_165', 'row_166', 'row_167', 'row_168', 'row_169', 'row_170', 'row_171', 'row_172', 'row_173', 'row_174', 'row_175', 'row_176', 'row_177', 'row_178', 'row_179', 'row_180', 'row_181', 'row_182', 'row_183', 'row_184', 'row_185', 'row_186', 'row_187', 'row_188', 'row_189', 'row_190', 'row_191', 'row_192', 'row_193', 'row_194', 'row_195', 'row_196', 'row_197', 'row_198', 'row_199', 'row_200', 'row_201', 'row_202', 'row_203', 'row_204', 'row_205', 'row_206', 'row_207', 'row_208', 'row_209', 'row_210', 'row_211', 'row_212', 'row_213', 'row_214', 'row_215', 'row_216', 'row_217', 'row_218', 'row_219', 'row_220', 'row_221', 'row_222', 'row_223', 'row_224', 'row_225', 'row_226', 'row_227', 'row_228', 'row_229', 'row_230', 'row_231', 'row_232', 'row_233', 'row_234', 'row_235', 'row_236', 'row_237', 'row_238', 'row_239', 'row_240', 'row_241', 'row_242', 'row_243', 'row_244', 'row_245', 'row_246', 'row_247', 'row_248', 'row_249', 'row_250', 'row_251', 'row_252', 'row_253', 'row_254', 'row_255', 'row_256', 'row_257', 'row_258', 'row_259', 'row_260', 'row_261', 'row_262', 'row_263', 'row_264', 'row_265', 'row_266', 'row_267', 'row_268', 'row_269', 'row_270', 'row_271', 'row_272', 'row_273', 'row_274', 'row_275', 'row_276', 'row_277', 'row_278', 'row_279', 'row_280', 'row_281', 'row_282', 'row_283', 'row_284', 'row_285', 'row_286', 'row_287', 'row_288', 'row_289', 'row_290', 'row_291', 'row_292', 'row_293', 'row_294', 'row_295', 'row_296', 'row_297', 'row_298', 'row_299', 'row_300', 'row_301', 'row_302', 'row_303', 'row_304', 'row_305', 'row_306', 'row_307', 'row_308', 'row_309', 'row_310', 'row_311', 'row_312', 'row_313', 'row_314', 'row_315', 'row_316'})];

% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
predictorNames = {'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67', 'row_68', 'row_69', 'row_70', 'row_71', 'row_72', 'row_73', 'row_74', 'row_75', 'row_76', 'row_77', 'row_78', 'row_79', 'row_80', 'row_81', 'row_82', 'row_83', 'row_84', 'row_85', 'row_86', 'row_87', 'row_88', 'row_89', 'row_90', 'row_91', 'row_92', 'row_93', 'row_94', 'row_95', 'row_96', 'row_97', 'row_98', 'row_99', 'row_100', 'row_101', 'row_102', 'row_103', 'row_104', 'row_105', 'row_106', 'row_107', 'row_108', 'row_109', 'row_110', 'row_111', 'row_112', 'row_113', 'row_114', 'row_115', 'row_116', 'row_117', 'row_118', 'row_119', 'row_120', 'row_121', 'row_122', 'row_123', 'row_124', 'row_125', 'row_126', 'row_127', 'row_128', 'row_129', 'row_130', 'row_131', 'row_132', 'row_133', 'row_134', 'row_135', 'row_136', 'row_137', 'row_138', 'row_139', 'row_140', 'row_141', 'row_142', 'row_143', 'row_144', 'row_145', 'row_146', 'row_147', 'row_148', 'row_149', 'row_150', 'row_151', 'row_152', 'row_153', 'row_154', 'row_155', 'row_156', 'row_157', 'row_158', 'row_159', 'row_160', 'row_161', 'row_162', 'row_163', 'row_164', 'row_165', 'row_166', 'row_167', 'row_168', 'row_169', 'row_170', 'row_171', 'row_172', 'row_173', 'row_174', 'row_175', 'row_176', 'row_177', 'row_178', 'row_179', 'row_180', 'row_181', 'row_182', 'row_183', 'row_184', 'row_185', 'row_186', 'row_187', 'row_188', 'row_189', 'row_190', 'row_191', 'row_192', 'row_193', 'row_194', 'row_195', 'row_196', 'row_197', 'row_198', 'row_199', 'row_200', 'row_201', 'row_202', 'row_203', 'row_204', 'row_205', 'row_206', 'row_207', 'row_208', 'row_209', 'row_210', 'row_211', 'row_212', 'row_213', 'row_214', 'row_215', 'row_216', 'row_217', 'row_218', 'row_219', 'row_220', 'row_221', 'row_222', 'row_223', 'row_224', 'row_225', 'row_226', 'row_227', 'row_228', 'row_229', 'row_230', 'row_231', 'row_232', 'row_233', 'row_234', 'row_235', 'row_236', 'row_237', 'row_238', 'row_239', 'row_240', 'row_241', 'row_242', 'row_243', 'row_244', 'row_245', 'row_246', 'row_247', 'row_248', 'row_249', 'row_250', 'row_251', 'row_252', 'row_253', 'row_254', 'row_255', 'row_256', 'row_257', 'row_258', 'row_259', 'row_260', 'row_261', 'row_262', 'row_263', 'row_264', 'row_265', 'row_266', 'row_267', 'row_268', 'row_269', 'row_270', 'row_271', 'row_272', 'row_273', 'row_274', 'row_275', 'row_276', 'row_277', 'row_278', 'row_279', 'row_280', 'row_281', 'row_282', 'row_283', 'row_284', 'row_285', 'row_286', 'row_287', 'row_288', 'row_289', 'row_290', 'row_291', 'row_292', 'row_293', 'row_294', 'row_295', 'row_296', 'row_297', 'row_298', 'row_299', 'row_300', 'row_301', 'row_302', 'row_303', 'row_304', 'row_305', 'row_306', 'row_307', 'row_308', 'row_309', 'row_310', 'row_311', 'row_312', 'row_313', 'row_314', 'row_315', 'row_316'};
predictors = inputTable(:, predictorNames);
response = inputTable.row_1;


% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 5);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

% Compute validation predictions and scores
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);