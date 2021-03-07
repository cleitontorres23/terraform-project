#cloud-config
ssh_authorized_keys:
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
        ExecStartPre=-/usr/bin/docker pull "nginx:1.13"
        ExecStart=/usr/bin/docker run --name nginx -d --net host -v /usr/share/nginx/html/index.html:/usr/share/nginx/html/index.html  nginx:1.18.0-alpine
        ExecStop=/usr/bin/docker stop nginx
        
        [Install]
        WantedBy=multi-user.target
        
  - path: /usr/share/nginx/html/index.html
    permission: '0644'
    content:  |  
        <html>
          <head>
            <title>VM${index}</title>
          </head>
          <body>
            <h1>“Hello World VM${index} !”</h1>
          </body>
        </html>