# Happy Paws
It is important for pet owners to keep track of their pet’s health. However, it could be difficult as time passes with more and more medical record. This is why an app is needed to keep all the records organized.

## Demonstration Video
https://youtu.be/ZLUHaDqDm3A

## Functions
In this app, users can store:  
  - Pets' Details  
    - Basic: Name, breed, date of birth, etc.  
    - Vaccine History  
    - Medical Records  
    - Notes  
  - Contacts of pet shops. pet hotels, vets, etc.  
  - To-Do List  
  - Appointment  
  - Storage  
    - Such as how many food the users have  
  - Pet shop  
 
## Structure  
Common icon: Pen => Edit     Bin => Delete  
There are 5 main pages on this app: Home, To-Do, Appointment, Storage, Shop  
  
### 0. Sign in/ Register
When the app is started, it will display a login page for the user to enter their email and password. If the user doesn't have an account, the user can tap on the "Don't have an account?" text and register an account.  

### 1. Homepage
Homepage displays lists of pet profiles and contacts of shops. On this page the users can add pet profiles and contacts.  
By tapping on the pet profile tiles, the app will show the details of the pet profile. Users can edit/delete the details here. 
By tapping on the pen icon on the contact tile, users can edit the contact details.  
By tapping on the avatar icon on the top right, the user can access the user profile page and sign out the app.

#### 1.1. Pet Profile
Users can store the following details:
- Pet Image
- Name
- Species
- Sex
- Breed
- Color
- Date of Birth
- Veterinarian

#### 1.2. Contact
Users can store the following details:
- Name
- Category: Groomer, Pet Boarding, Pet Sitter, Vet, Others
- Phone
- Address
- Email

#### 1.3. User Profile Page
Displays the users' email and a sign out button

### 2. To-Do  
On this page, the user can view/ delete their To-Do list item. After finishing that item, the user can tap on the checkbox.  
The user can add a new item by tapping on the bottom right '+' button.  

### 3. Appointment  
On this page, the user can view their appointments. All appointments are displayed under the calendar. The users can select a date on the calendar. If the selected date is the same as the start/end date of an appointment, that appointment will be highlighted.  
The user can add a new appointment by tapping on the bottom right '+' button. 

Users can store the following details:  
- Title  
- Start Date  
- Start Time  
- End Date  
- End Time  
- Pet  
- Location  

### 4. Storage   
On this page, users can view their storage items. When the quantity of the items is lower than the quantity alert threshold and if the quantity alert is on, a pink border will appear around the item tile.  
The user can add a new item by tapping on the bottom right '+' button.  

Users can store the following details:  
- Item Image  
- Name  
- Quantity  
- Quantity Alert  
- Quantity Alert Threshold    

### 5. Shop   
On this page, users can view a list of selected online pet shops. By tapping on to the tiles, the website of that pet shop will pop up.  

## How to run in Flutter  
1. Install Flutter  
2. Clone this repo    
```
git clone https://github.com/abichoi/Happy_Paws2.git
```
4. Set up Firebase --> https://console.firebase.google.com.
- Sign in to Firebase
- Create a project
- Enable email sign-in for Firebase Authentication
- Enable Cloud Firestore
- Create database
6. Add Firebase to the Flutter App --> https://firebase.google.com/docs/flutter/setup?platform=android
7. Import all libraries below:
  cupertino_icons: ^1.0.2
  flutter_boxicons: ^3.0.0
  firebase_core: ^1.15.0
  firebase_auth: ^3.3.15
  firebase_storage: ^10.2.13
  cloud_firestore: ^3.1.13
  image_picker: ^0.8.5
  font_awesome_flutter: ^10.1.0
  persistent_bottom_nav_bar: ^4.0.2
  intl: ^0.17.0
  table_calendar: ^3.0.5
  url_launcher: ^6.1.0

## Initial Repo
https://github.com/abichoi/Happy_Paws  
For unknow reason the project in the inital repo could not run the Emulator. But with the same code but in a new project the emulator is running normally.  
The inital repo is kept for the record of the first three commit.

## Initial Design
![image](https://user-images.githubusercontent.com/91946874/168743686-af7243c0-f1ad-4d66-86c9-2c5a653829a0.png)
![image](https://user-images.githubusercontent.com/91946874/168743988-f1b6d24c-3e71-47ee-91e3-bc76104affec.png)
![image](https://user-images.githubusercontent.com/91946874/168744101-86792173-8bb7-4b87-a3a5-ec0b11b6178a.png)
![image](https://user-images.githubusercontent.com/91946874/168744154-fc5ddef4-b016-4d44-9350-d43b213c0ecb.png)
![image](https://user-images.githubusercontent.com/91946874/168744194-97898dbc-2d86-4ea7-9325-17ba85a5a1a8.png)
![image](https://user-images.githubusercontent.com/91946874/168744226-214bd010-f26a-4a08-95ff-5af7a36d5ee2.png)
![image](https://user-images.githubusercontent.com/91946874/168744264-7555073f-ddd6-4ceb-8f58-132d9554627e.png)
![image](https://user-images.githubusercontent.com/91946874/168744309-79e5c9eb-37d4-45ae-bf90-36ae6749930b.png)
![image](https://user-images.githubusercontent.com/91946874/168744350-fac8bd2d-ac7b-4a88-bf01-225ad240acd1.png)
![image](https://user-images.githubusercontent.com/91946874/168744387-acdd08f0-dc2b-43a1-a0b8-7fb203e3c8dd.png)
![image](https://user-images.githubusercontent.com/91946874/168744436-4bb582bd-3bea-4d75-8850-af34823472d0.png)




