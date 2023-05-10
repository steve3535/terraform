#!/usr/local/bin/python3
import pandas as pd

# Replace 'input_file.xlsx' with your Excel file name
input_file = '/var/tmp/in.xlsx'
# Replace 'output_file.csv' with your desired CSV output file name
output_file = '/var/tmp/out.csv'

# Read the Excel file
df = pd.read_excel(input_file, engine='openpyxl')

# Save the data to a CSV file
df.to_csv(output_file, index=False)

