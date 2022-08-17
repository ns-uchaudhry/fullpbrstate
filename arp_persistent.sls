file|net|arp_persistent:
  file.managed:
    - name: /etc/network/if-up.d/arp_rule_restore.sh
    - user: root
    - group: root
    - mode: 0764
    - contents: |
        #!/bin/bash
        echo `arptables-restore < /opt/lbaas_rule_file/arprules`
