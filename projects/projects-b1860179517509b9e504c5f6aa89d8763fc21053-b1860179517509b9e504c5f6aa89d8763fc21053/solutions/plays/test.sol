---
- name: Test web service
  hosts: win1.example.com
  gather_facts: false

  tasks:

    - name: Connect to internet web server
      win_uri:
        url: "{{ url }}"
        status_code: 200