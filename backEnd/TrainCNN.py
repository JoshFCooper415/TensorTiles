import torch.nn.functional as F
import torch.optim as optim
from ConvNet import ConvNetLayers
from CIFAR10DataLoader import CIFAR10DataLoader
from MNISTDataLoader import MNISTDataLoader

class CNNTrainer:
    def __init__(self, layer_specs, hyper_parameters, dataset):
        self.layer_specs = layer_specs
        self.hyper_parameters = hyper_parameters
        self.model = ConvNetLayers(self.layer_specs)
        self.optimizer = optim.SGD(self.model.parameters(), lr=self.hyper_parameters.get("learning_rate"))
        if dataset == "CIFAR10":
            self.cifar_data = CIFAR10DataLoader()
            self.train_loader = self.cifar_data.get_trainloader()
            self.test_loader = self.cifar_data.get_testloader()
            self.classes = self.cifar_data.get_classes()
        if dataset == "MNIST":
            self.mnist_data = MNISTDataLoader()
            self.train_loader = self.mnist_data.get_trainloader()
            self.test_loader = self.mnist_data.get_testloader()
            self.classes = self.mnist_data.get_classes()

    def train(self):
        for epoch in range(self.hyper_parameters.get("num_epochs")):
            for batch_idx, (data, target) in enumerate(self.train_loader):
                self.optimizer.zero_grad()
                output = self.model(data)
                loss = F.cross_entropy(output, target)
                loss.backward()
                self.optimizer.step()
                
                if batch_idx % 5 == 0:
                    print(f"Train Epoch [{epoch+1}/{self.hyper_parameters.get('num_epochs')}], Step [{batch_idx}/{len(self.train_loader)}], Loss: {loss.item():.4f}")
            for batch_idx, (data, target) in enumerate(self.test_loader):
                self.optimizer.zero_grad()
                output = self.model(data)
                loss = F.cross_entropy(output, target)
                loss.backward()
                self.optimizer.step()
                
                if batch_idx % 5 == 0:
                    print(f"Test Epoch [{epoch+1}/{self.hyper_parameters.get('num_epochs')}], Step [{batch_idx}/{len(self.test_loader)}], Loss: {loss.item():.4f}")

if __name__ == "__main__":
    layer_specs = [
        {'in_channels': 1, 'out_channels': 32, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.2},
        {'in_channels': 32, 'out_channels': 64, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.3},
        {'in_channels': 64, 'out_channels': 128, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.4}
    ]
    hyper_parameters = {'learning_rate': 0.001, 'num_epochs': 10}

    cnn_trainer = CNNTrainer(layer_specs, hyper_parameters, "CIFAR10")
    cnn_trainer.train()
