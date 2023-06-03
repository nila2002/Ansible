---
- name: Configure a host using DSC
  hosts: all
  vars:
    directory_location: C:\DO417\projects-review\
    file_name: "{{ directory_location }}new-file.txt"
    windows_resource: WindowsFeature
    feature_name: telnet-client
    zip_file_location: files/do417-example.zip
    zip_remote_location: "{{ directory_location }}do417-example.zip"
    zip_extracted_location: "{{ directory_location }}extracted-zip"

  tasks:
       
    - name: Create a new directory
      win_dsc:
        resource_name: File
        DestinationPath: "{{ directory_location }}"
        Ensure: Present
        Type: Directory

    - name: Create a new file with text
      win_dsc:
        resource_name: File
        DestinationPath: "{{ file_name }}"
        Contents: |
            Hello
            This is the DO417 course.
        Ensure: Present
        Type: File
    
    - name: Install a Windows feature 
      win_dsc:
        resource_name: "{{ windows_resource }}"
        Name: "{{ feature_name }}"

    - name: Copy a zip file to the managed host
      win_copy:
        src: "{{ zip_file_location }}"
        dest: "{{ zip_remote_location }}"
    
    - name: Extract a zip file in the new directory
      win_dsc:
        resource_name: Archive
        Destination: "{{ zip_extracted_location }}"
        Path: "{{ zip_remote_location }}"
        Ensure: Present