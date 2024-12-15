import pandas as pd

def extract_patient_info(file_path):
    # Read the Excel file
    df = pd.read_excel(file_path)

    # Iterate over each row and extract patient information
    for index, row in df.iterrows():
        patient_id = row['PatientID']
        patient_name = row['PatientName']
        patient_age = row['PatientAge']
        patient_gender = row['PatientGender']
        
        # Print the patient information
        print(f"Patient ID: {patient_id}")
        print(f"Patient Name: {patient_name}")
        print(f"Patient Age: {patient_age}")
        print(f"Patient Gender: {patient_gender}")
        print("-" * 20)

if __name__ == "__main__":
    file_path = "path/to/patient_info.xlsx"  # Update with the actual file path
    extract_patient_info(file_path)
