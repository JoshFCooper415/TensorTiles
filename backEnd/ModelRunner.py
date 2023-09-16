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
        params = args[1]
        modelType = args[2]
        # Initialize and run the model
        paris_housing_model = Regressions(params)
        paris_housing_model.load_and_prepare_paris_data()

        if modelType == 'regression':
            paris_housing_model.train_model_regression()
            metrics = paris_housing_model.evaluate_model()
        elif modelType == 'random forest':
            paris_housing_model.train_model_random_forest()
            paris_housing_model.evaluate_model()

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
    #args = ["Regression",{'iterations': 500,'learning_rate': 0.1,'depth': 6,'n_estimators': 50,'target': 'price'},'random forest']
    #MNIST in = 1 out = 4
    #CIFAR in = 3 out = 10
    args = ["CNN",
            [
            {'in_channels': 3, 'out_channels': 64, 'kernel_size': 2, 'use_bn': True, 'dropout_rate': 0.2},
            {'in_channels': 64, 'out_channels': 10, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.3},
            ],
            {'learning_rate': 0.001, 'num_epochs': 1},
            "CIFAR10"]
    
    runner = ModelRunner(args)
    
    runner.run()
