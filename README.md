# webgis_homework_oss_server_depl
Depoly QGIS Server using docker

```bash
docker build -t webgis_hw_oss_server_depl .
docker run -p 80:80 -p 443:443 webgis_hw_oss_server_depl
```
