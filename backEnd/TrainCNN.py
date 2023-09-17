import torch.nn.functional as F
import torch.optim as optim
import torch
import torch.nn as nn
from ConvNet import ConvNetLayers
from CIFAR10DataLoader import CIFAR10DataLoader
from MNISTDataLoader import MNISTDataLoader
from FasionMNISTDataLoader import FashionMNISTDataLoader
from STLDataLoader import STLDataLoader

class CNNTrainer:
    def __init__(self, layer_specs, hyper_parameters, dataset):
        self.layer_specs = layer_specs
        self.hyper_parameters = hyper_parameters
        self.model = ConvNetLayers(self.layer_specs)
        self.model.initialize_fc(dataset)
        self.acc_arr = []
        self.optimizer = optim.Adam(self.model.parameters(), lr=self.hyper_parameters.get("learning_rate"))

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
        if dataset == "FashionMNIST":
            self.fasion_data = FashionMNISTDataLoader()
            self.train_loader = self.fasion_data.get_trainloader()
            self.test_loader = self.fasion_data.get_testloader()
            self.classes = self.fasion_data.get_classes()

    def train(self):
        num_epochs = self.hyper_parameters.get("num_epochs")
        criterion = nn.CrossEntropyLoss()
        for epoch in range(num_epochs):
            # Training loop
            self.model.train()
            train_loss = 0.0
            for batch_idx, (data, target) in enumerate(self.train_loader):
                self.optimizer.zero_grad()
                output = self.model(data)
                loss = criterion(output, target)
                loss.backward()
                self.optimizer.step()
                train_loss += loss.item()

                if batch_idx % 5 == 0:
                    print(f"Train Epoch [{epoch+1}/{num_epochs}], Step [{batch_idx}/{len(self.train_loader)}], Loss: {loss.item():.4f}")

            train_loss /= len(self.train_loader)
            print(f"Train Epoch [{epoch+1}/{num_epochs}], Average Loss: {train_loss:.4f}")

            # Test (or Validation) loop
            self.model.eval()
            test_loss = 0.0
            correct = 0
            with torch.no_grad():
                for data, target in self.test_loader:
                    output = self.model(data)
                    loss = F.cross_entropy(output, target, reduction='sum')
                    test_loss += loss.item()
                    pred = output.argmax(dim=1, keepdim=True)
                    correct += pred.eq(target.view_as(pred)).sum().item()

            test_loss /= len(self.test_loader.dataset)
            accuracy = 100. * correct / len(self.test_loader.dataset)
            self.acc_arr.append(accuracy)
            print(f"Test Epoch [{epoch+1}/{num_epochs}], Average Loss: {test_loss:.4f}, Accuracy: {accuracy:.2f}%")
