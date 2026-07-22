package com.rakesh.elams.model;

public class Employee {

    private int employee_id;
    private String employee_name;
    private String email;
    private long phone;
    private String department;
    private String designation;

    private Integer managerId;
    private String managerName;

    // =========================================
    // CONSTRUCTOR
    // =========================================

    public Employee() {
    }

    public Employee(
            int employee_id,
            String employee_name,
            String email,
            long phone,
            String department,
            String designation) {

        this.employee_id = employee_id;
        this.employee_name = employee_name;
        this.email = email;
        this.phone = phone;
        this.department = department;
        this.designation = designation;
    }

    // =========================================
    // EMPLOYEE ID
    // =========================================

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    // =========================================
    // EMPLOYEE NAME
    // =========================================

    public String getEmployee_name() {
        return employee_name;
    }

    public void setEmployee_name(String employee_name) {
        this.employee_name = employee_name;
    }

    // =========================================
    // EMAIL
    // =========================================

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // =========================================
    // PHONE
    // =========================================

    public long getPhone() {
        return phone;
    }

    public void setPhone(long phone) {
        this.phone = phone;
    }

    // =========================================
    // DEPARTMENT
    // =========================================

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    // =========================================
    // DESIGNATION
    // =========================================

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    // =========================================
    // MANAGER ID
    // =========================================

    public Integer getManagerId() {
        return managerId;
    }

    public void setManagerId(Integer managerId) {
        this.managerId = managerId;
    }

    // =========================================
    // MANAGER NAME
    // =========================================

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    // =========================================
    // TO STRING
    // =========================================

    @Override
    public String toString() {

        return "Employee [employee_id=" + employee_id
                + ", employee_name=" + employee_name
                + ", email=" + email
                + ", phone=" + phone
                + ", department=" + department
                + ", designation=" + designation
                + ", managerId=" + managerId
                + ", managerName=" + managerName
                + "]";
    }
}