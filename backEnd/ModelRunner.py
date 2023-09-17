from TrainReg import Regressions
from TrainCNN import CNNTrainer
import torch
import torch
from PIL import Image
from torchvision import transforms


class ModelRunner:
    def __init__(self, args):
        self.args = args
        if args == None:
            return None

    def run(self):
        if self.args[0] == "Regression":
            return self.run_regression_model()
        elif self.args[0] == "CNN":
            return self.run_cnn_model()
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
        self.model = Regressions(params)
        if dataset == "paris":
            self.model.load_and_prepare_paris_data()
        elif dataset == "boston":
            self.model.load_and_prepare_boston_data()
        elif dataset == "insurance":
            self.model.load_and_prepare_insurance_data
        print('training')
        if modelType == 'regression':
            self.model.train_model_regression()
            return self.model.evaluate_model()
        elif modelType == 'random forest':
            self.model.train_model_random_forest()
            return self.model.evaluate_model()

    def run_cnn_model(self):
        '''layer_specs = [
            {'in_channels': 1, 'out_channels': 32, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.2},
            {'in_channels': 32, 'out_channels': 64, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.3},
            {'in_channels': 64, 'out_channels': 128, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.4}
        ]
        hyper_parameters = {'learning_rate': 0.001, 'num_epochs': 10}'''
        if 'MNIST' in self.args[3]:
            self.args[1][0]["in_channels"] = 1
        self.model = CNNTrainer(self.args[1], self.args[2], self.args[3])
        self.model.train()
        return self.model.acc_arr

    def inferance(self, input_image):
        preprocess = transforms.Compose([
            transforms.Resize(256),
            transforms.CenterCrop(224),
            transforms.ToTensor(),
            transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[
                                 0.229, 0.224, 0.225]),
        ])

        input_tensor = preprocess(input_image)

        input_batch = input_tensor.unsqueeze(0)
        # Run the model
        with torch.no_grad():  # Deactivates autograd, reduces memory usage and speeds up computations
            output = self.model.model(input_batch)

        _, predicted_class = torch.max(output, 1)
        print(f"Predicted class: {predicted_class.item()}")
        return predicted_class.item()


if __name__ == '__main__':
    # args = ["Regression",{'learning_rate': 0.00001,'depth': 10,'n_estimators': 100,'target': 'hasStorageRoom', 'dropedFeatures': []},'random forest','paris']

    args = ["CNN",
            [
                {'in_channels': 3, 'out_channels': 64, 'kernel_size': 5,
                    'use_bn': True, 'dropout_rate': 0.0},
            ],
            {'learning_rate': 1e-4, 'num_epochs': 1},
            "MNIST"]
    runner = ModelRunner(args)
    # runner.run()
    print(f'top acc {runner.run()}')
