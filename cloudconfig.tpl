#cloud-config
ssh_authorized_keys:
  - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClIib6GO9OJ76qXo7o94VPvr8LRlWIhB1IMwhZCdUI13OaJ0lb8xpT+MF3WN93FpkKO2GDGiKRS4rtGsP6dCP4JHoaMiiDGwXXlZxh6kvpjQdxF7g15rMyQsAb/LrvZ/nV5OxQTLL4nBLY/YlNvH5WdugE81hxMtp8IUkYJpXeJfmS7T8XXDPnVPx6oCnxKqXy0GBNpJNGzVe51rLavJC2dhYYif3RBy5hxM/7AGzLNseXwv5/7t7c3cS4PMGr17HxNnOfQqQMSbbYZWcePkVlJdLxPBsvo+yNUUHEsdXzhdLdAxRLMLslLv6SVCxYFxIfYx4sR/5/eF9fytR15cjR cstsantos@cstsantos-sre"
  
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