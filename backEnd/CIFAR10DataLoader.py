import torch
import torchvision
import torchvision.transforms as transforms

class CIFAR10DataLoader:
    def __init__(self, root='./data', batch_size=32, num_workers=2):
        self.root = root
        self.batch_size = batch_size
        self.num_workers = num_workers
        self.transform = transforms.Compose(
            [transforms.ToTensor(),
             transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))]
        )
        self.classes = ('plane', 'car', 'bird', 'cat',
                        'deer', 'dog', 'frog', 'horse', 'ship', 'truck')
        
        self.trainset = torchvision.datasets.CIFAR10(root=self.root, train=True,
                                                     download=True, transform=self.transform)
        self.trainloader = torch.utils.data.DataLoader(self.trainset, batch_size=self.batch_size,
                                                       shuffle=True, num_workers=self.num_workers)
        
        self.testset = torchvision.datasets.CIFAR10(root=self.root, train=False,
                                                    download=True, transform=self.transform)
        self.testloader = torch.utils.data.DataLoader(self.testset, batch_size=self.batch_size,
                                                      shuffle=False, num_workers=self.num_workers)
    
    def get_trainloader(self):
        return self.trainloader
    
    def get_testloader(self):
        return self.testloader
    
    def get_classes(self):
        return self.classes
