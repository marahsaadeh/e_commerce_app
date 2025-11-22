# **E-Commerce Flutter App**

A complete Flutter project built as part of the **Code2Career: Flutter Project – Milestone 1**.
This application demonstrates authentication, state management, local data storage, API integration, Firebase services, and a clean UI/UX structure.

---

## ⭐ **Overview**

This Flutter e-commerce app allows users to browse products, view product details, add items to the cart, check out, and manage their profile.
The project showcases full understanding of:

* **State Management (Provider)**
* **Local Database (Sqflite)**
* **SharedPreferences**
* **Remote API calling**
* **Firebase Authentication**
* **Clean and scalable project structure**
* **UI/UX best practices**

---

## 🔥 **Main Features**

### **✔ Authentication**

* User Login
* Registration
* Logout
* Email Verification
* Google Sign-in

### **✔ Navigation**

Includes at least **5+ screens**:

1. Sign In
2. Registration
3. Home
4. Details Page
5. Checkout Page
6. Profile Page
7. Forgot Password
8. Verify Email

### **✔ Local Data Storage**

* SharedPreferences → save username, email, remember me
* Sqflite → save product list locally

### **✔ Remote API**

* Fetching products from **FakeStoreAPI**
* Saving API results to local database
* Displaying products in GridView

### **✔ Firebase**

* Firebase Auth (email/pass + Google sign-in)
* Firestore Database (store user data)
* Firebase Storage (optional for images)

### **✔ Cart System (Provider — State Management)**

* Add to Cart
* Total Price
* Cart Items Counter

### **✔ UI / UX**

* Clean design
* Consistent colors
* Drawer menu
* Custom AppBar
* Snackbar for notifications

---

## 📁 **Project Structure**

```
lib/
 ├── data/
 │    └── products_database.dart
 ├── pages/
 │    ├── checkout.dart
 │    ├── details_screen.dart
 │    ├── forgot_password.dart
 │    ├── home.dart
 │    ├── profile_page.dart
 │    ├── register.dart
 │    ├── sign_in.dart
 │    └── verify_email.dart
 ├── provider/
 │    ├── cart.dart
 │    └── google_signin.dart
 ├── shared/
 │    ├── appbar.dart
 │    ├── colors.dart
 │    ├── constants.dart
 │    ├── data_from_firestore.dart
 │    └── snackbar.dart
 └── main.dart
```

---

## 🛠 **Technologies Used**

| Technology        | Usage                   |
| ----------------- | ----------------------- |
| Flutter           | App development         |
| Provider          | State management        |
| Firebase Auth     | Login/Register          |
| Firestore         | User data               |
| SharedPreferences | Local simple storage    |
| Sqflite           | Local products database |
| FakeStore API     | Fetch product list      |
| HTTP package      | API requests            |

---

## 🖼 **Screenshots**

### 🔐 Authentication Screens

| Login                                                                                                     | Forgot Password                                                                                           | Register                                                                                                  |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| <img width="250" src="https://github.com/user-attachments/assets/6937ebee-4d1a-475b-80f2-23205b65ba22" /> | <img width="250" src="https://github.com/user-attachments/assets/a40035ef-b615-465a-b68b-6a68293e8256" /> | <img width="250" src="https://github.com/user-attachments/assets/f74ac6bc-d984-47ff-a90b-34e369545320" /> |

---

### 🏠 Home & Product Browsing

| Home                                                                                                      | Add to Cart                                                                                               | Drawer                                                                                                    |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| <img width="250" src="https://github.com/user-attachments/assets/cdaed073-e287-4a90-b723-b4dc77d74acb" /> | <img width="250" src="https://github.com/user-attachments/assets/ace2d726-cf0f-4e3f-9920-2dac30449168" /> | <img width="250" src="https://github.com/user-attachments/assets/ecfaa918-8576-4e2b-baeb-8e049a296ea7" /> |

---

### 🛒 Cart & Product Details

| Cart                                                                                                      | Remove From Cart                                                                                          | Details Screen                                                                                            |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| <img width="250" src="https://github.com/user-attachments/assets/327ace15-43b5-47de-9ec6-5171341f8512" /> | <img width="250" src="https://github.com/user-attachments/assets/c87ceda4-7a69-4f80-9ae7-a14f4d6c472b" /> | <img width="250" src="https://github.com/user-attachments/assets/40e98ad7-ab1c-4106-b6b2-9b9c36df76f6" /> |

---

## 🚀 **How to Run This Project**

### **1️⃣ Clone the Repository**

```bash
git clone https://github.com/marahsaadeh/e_commerce_app.git
```

### **2️⃣ Open Project Folder**

```bash
cd <project-folder>
```

### **3️⃣ Install Dependencies**

```bash
flutter pub get
```

### **4️⃣ Run Emulator**

Open emulator or connect your device.

### **5️⃣ Run the App**

```bash
flutter run
```

---

## 🔐 **Security & Best Practices Used**

* Validations with **Regular Expressions**
* Verify Email (prevent fake accounts)
* Snackbar messages for user feedback
* Storing sensitive data securely
* Using Provider instead of setState for cleaner state management

---

## 🎯 **Project Status**

Fully functional, tested, and ready for review by the Testing and UI team at Gaza Sky Geeks.

---

## ❤️ **Thank You for Reviewing My Project**
