install|arptables:
  pkg.installed:
     - name: arptables

create|arp-rule|file:
     file.managed:    
       - name: /opt/lbaas_rule_file/arprules
       - source: salt://fullpbrstate/templates/arprule.template
       - makedirs: True
       - template: jinja
       - require:
         - pkg: install|arptables

load|therules:
     cmd.run:
       - name: arptables-restore < /opt/lbaas_rule_file/arprules
       - require:
         - file: create|arp-rule|file
