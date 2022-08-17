include:
  - fullpbrstate.arptables
  - fullpbrstate.arp_persistent


network|iproute2|rt_addition:
  file.append:
    - name: /etc/iproute2/rt_tables
    - text: |
        100	nlbedsr

route_table_service:
     cmd.run:
       - name: systemctl restart networking.service
       - onchanges:
         - file: network|iproute2|rt_addition

route_file:
     file.append:
       - name: /etc/network/interfaces
       - source: salt://fullpbrstate/templates/route.template
       - makedirs: True
       - template: jinja
       - require:
         - file: network|iproute2|rt_addition

route_service:
     cmd.run:
       - name: systemctl restart networking.service
       - onchanges:
         - file: route_file
