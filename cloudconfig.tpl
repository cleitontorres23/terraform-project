#cloud-config
ssh_authorized_keys:
  - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxW8rcgzqcyOv0h4StvnplNUuiuKJR7BS1w1k644a1hxxEzXKSO12Fw1WTrm15jhkNI0liCp1mVE1I/JEqH2pOoOCkkcK5lcefZRr/1Lduj5VH0myF2wDej2U+mYYCIF6jsKXSMfX49jhQTTX8rXE8Iw28/wRBcbda+cpJPmgaTMg/IsQfCN0w4mV+GhyeYtLaFf5U6ZwRWRa+KL9Wy3oQ5mhar/0gTiYcKA8r3JHEe+QvNC9Z4koKMDLBy57eJRPvM79ut2QhKWAolsCBRpHnMHOcdLcsCaNEWNPNUqgRceQqYieDaN+ySHvYG4nJwCLye0tgsUBEkDrOz7hM7TDijPhcejrjr0y1hzmk14k4xxR4jDJrubhn237QUrkLqxSaneIa0DKEx3bqGnKIM2Q6Xh59jmgvoffOJE0BmEcNECC/8fQFI7u5biA65uNYjmpgKrFxvzE2gJHjnGzpO2XRuidFJYiZTCDoOfDrrcuERcNkvvp1Lkqu21iByDVIbyTLOjRHea6+pfCBTTuVj1e1+3xG3u9jQDFyiZpMR7cDwPGOBRPwh3tERdBrfJg5H/K82o76tV1SDGUKVwWeHz+zzF2rF7083Z4H3pqcx/pdnqzn0GYrFHZXUoiCyyl8BbVQ3hNNdCEXmxlsIJALlHuWYc/kdA86D+CgNllcg3P2kQ== cstsantos@cstsantos-sre"
  - "ssh-rsa id_rsa.pub"

runcmd:
  - sudo -i
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  - sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - sudo apt update -y
  - sudo apt install docker-ce docker-ce-cli containerd.io -y
  - sudo systemctl start docker
  - sudo systemctl enable docker
  - sudo systemctl start nginx
  - sudo systemctl enable nginx
  
write_files:
  - path: /lib/systemd/system/nginx.service
    permission: '0644'
    content:  |
        [Unit]
        Description=nginx (Docker)
        After=docker.service
        Requires=docker.service
        
        [Service]
        TimeoutStartSec=0
        Restart=always
        ExecStartPre=-/usr/bin/docker kill nginx
        ExecStartPre=-/usr/bin/docker rm nginx
        ExecStartPre=-/usr/bin/docker pull "nginx:1.18.0-alpine"
        ExecStart=/usr/bin/docker run --name nginx -d --net host -v /usr/share/nginx/html/index.html:/usr/share/nginx/html/index.html  nginx:1.18.0-alpine
        ExecStop=/usr/bin/docker start nginx
        
        [Install]
        WantedBy=multi-user.target
        
  - path: /usr/share/nginx/html/index.html
    permission: '0644'
    content:  |  
        <html>
          <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
            <title>VM${index}</title>
          </head>
          <body>
            <h1>Hello World VM${index} !</h1>
          </body>
        </html>