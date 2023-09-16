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
        self.target = params.get('target')
        self.catboost_model = None

    def load_and_prepare_paris_data(self):
        # Extract the CSV file from the ZIP file
        with zipfile.ZipFile('ParisHousingData.zip', 'r') as zip_ref:
            zip_ref.extractall('./')
        
        # Load the CSV file into a pandas DataFrame
        self.df = pd.read_csv('ParisHousing.csv')
        
        # Feature matrix
        self.X = self.df.drop(self.params.get('target'), axis=1)
        for feature in self.params.get('dropedFeatures'):
            self.X = self.X.drop(feature, axis=1)
        
        # Target variable
        self.y = self.df[self.params.get('target')]

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

