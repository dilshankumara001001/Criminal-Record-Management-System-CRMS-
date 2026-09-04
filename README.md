# 👮 Criminal Record Management System (CRMS)

A comprehensive web-based **Criminal Record Management System** designed for Sri Lanka Police to efficiently manage criminal records, complaints, cases, and generate analytical reports.

![CRMS Dashboard](https://img.shields.io/badge/Version-1.0-blue)
![PHP](https://img.shields.io/badge/PHP-8.2-purple)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📌 Features

### 🔐 Authentication & Security
- Secure Login/Logout system
- Session management with PHP
- Role-based access control (Admin, OIC, Investigator, Officer)
- Password hashing for security

### 📊 Dashboard
- Real-time statistics cards
  - Total Arrested Criminals
  - Solved Cases
  - Under Investigation Cases
  - Today's Complaints
- Recent activities feed
- Interactive charts and graphs

### 👤 Criminal Management
- Add, View, Edit, Delete criminal records
- Search by Name or NIC
- Status tracking (Arrested, Investigation, Released, Wanted, Court)
- Police station assignment
- Criminal code generation

### 📝 Complaint Management
- Register new complaints
- Track complaint status (Pending, Investigating, Resolved, Rejected)
- Severity levels (Low, Medium, High, Critical)
- Police station assignment
- Complaint code generation

### ⚖️ Case Management
- Create and track legal cases
- Case status (Open, Ongoing, Court, Closed)
- Priority levels (Low, Medium, High, Urgent)
- Court name and next hearing date tracking
- Case code generation

### 📈 Reports & Analytics
- Monthly crime trend charts
- Crime type distribution charts
- PDF report generation
- Excel export functionality
- Print reports

### 🗄️ Database Features
- 18+ optimized database tables
- Foreign key relationships
- Sample data for testing
- Support for 26 crime categories (Sri Lanka Police)
- Audit trail and system logs

---

## 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| **Frontend** | HTML5, CSS3, JavaScript, Chart.js |
| **UI Framework** | Custom CSS with animations (Poppins Font, Font Awesome) |
| **Backend** | PHP 8.2 |
| **Database** | MySQL 8.0 / MariaDB |
| **Server** | Apache (XAMPP) |
| **API** | RESTful API (JSON) |
| **Charts** | Chart.js |
| **Icons** | Font Awesome 6.5 |

---

## 🚀 Installation Guide

### Prerequisites

- XAMPP (Apache + MySQL + PHP)
- Web Browser (Chrome/Firefox recommended)

### Step 1: Clone or Download

```bash
git clone https://github.com/yourusername/criminal-record-management-system.git
