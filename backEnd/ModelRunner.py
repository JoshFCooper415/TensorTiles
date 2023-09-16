from TrainReg import Regressions
from TrainCNN import CNNTrainer

class ModelRunner:
    def __init__(self, args):
        self.args = args

    def run(self):
        if self.args[0] == "Regression":
            self.run_regression_model()
        elif self.args[0] == "CNN":
            self.run_cnn_model()
        else:
            print("Invalid argument.")

    def run_regression_model(self):
        '''params = {
            'iterations': 500,
            'learning_rate': 0.1,
            'depth': 6,
            'n_estimators': 50,
            'target': 'price',
            'dropedFeatures': []
        }
        modelType = 'random forest'
        '''
        params = self.args[1]
        modelType = self.args[2]
        dataset = self.args[3]
        # Initialize and run the model
        model = Regressions(params)
        if dataset == "paris":
            model.load_and_prepare_paris_data()
        elif dataset == "new":
            model.load_and_prepare_new_data()
        if modelType == 'regression':
            model.train_model_regression()
            print(model.evaluate_model())
        elif modelType == 'random forest':
            model.train_model_random_forest()
            print(model.evaluate_model())

    def run_cnn_model(self):
        '''layer_specs = [
            {'in_channels': 1, 'out_channels': 32, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.2},
            {'in_channels': 32, 'out_channels': 64, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.3},
            {'in_channels': 64, 'out_channels': 128, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.4}
        ]
        hyper_parameters = {'learning_rate': 0.001, 'num_epochs': 10}'''

        cnn_trainer = CNNTrainer(args[1], args[2], args[3])
        cnn_trainer.train()


if __name__ == '__main__':
    #args = ["Regression",{'learning_rate': 0.00001,'depth': 10,'n_estimators': 100,'target': 'hasStorageRoom', 'dropedFeatures': []},'random forest','dataset']

    args = ["CNN",
            [
            {'in_channels': 3, 'out_channels': 64, 'kernel_size': 5, 'use_bn': True, 'dropout_rate': 0.0}
            ],
            {'learning_rate': 1e-4, 'num_epochs': 10},
            "AudioMNIST"]
    
    runner = ModelRunner(args)
    
    runner.run()
