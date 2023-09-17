import pandas as pd
import zipfile
from reggresion import CatBoostRegression
from randomForest import CatForest


class Regressions:
    def __init__(self, params):
        self.params = params
        self.df = None
        self.X = None
        self.y = None
        self.target = params.target
        self.catboost_model = None

    def load_and_prepare_paris_data(self):
        # Extract the CSV file from the ZIP file
        # Load the CSV file into a pandas DataFrame
        self.df = pd.read_csv('ParisHousing.csv')

        # Feature matrix
        self.X = self.df.drop(self.params.target, axis=1)

        # Target variable
        self.y = self.df[self.params.target]

    def load_and_prepare_boston_data(self):
        # No need to extract from a ZIP file for this dataset
        # Load the CSV file directly from the URL into a pandas DataFrame
        url = 'https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv'
        self.df = pd.read_csv(url)

        # Feature matrix
        self.X = self.df.drop(self.params.target, axis=1)
        for feature in self.params.dropedFeatures:
            self.X = self.X.drop(feature, axis=1)

        # Target variable
        self.y = self.df[self.params.target]

    def load_and_prepare_insurance_data(self):
        # Load the CSV file directly from the URL into a pandas DataFrame
        url = 'https://raw.githubusercontent.com/stedy/Machine-Learning-with-R-datasets/master/insurance.csv'
        self.df = pd.read_csv(url)

        # Feature matrix
        self.X = self.df.drop(self.params.target, axis=1)
        for feature in self.params.dropedFeatures:
            self.X = self.X.drop(feature, axis=1)

        # Target variable
        self.y = self.df[self.params.target]

    def train_model_regression(self):
        # Initialize and prepare data for the CatBoost model
        self.catboost_model = CatBoostRegression(self.params)
        self.catboost_model.prepare_data(self.X, self.y)

        self.catboost_model.train()

    def train_model_random_forest(self):
        # Initialize and prepare data for the Random Forest model
        self.catboost_model = CatForest(self.params)
        self.catboost_model.prepare_data(self.X, self.y)
        # Train the model
        self.catboost_model.train()

    def evaluate_model(self):
        # Evaluate the model
        return self.catboost_model.evaluate()

    def predict(self, X_new):
        # Make predictions on new data
        return self.catboost_model.predict(X_new)
