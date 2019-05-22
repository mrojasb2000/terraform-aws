
<h1>Docker</h1>
https://www.docker.com/


Dockerfile definition:

FROM org.example/centos:7.6.1810

RUN curl -sL http://rpm.nodesource.com/setup_8.x | bash -
RUN yum -y-install nodejs
RUN node --version

----------------------------------------------------------

FROM org.example/nodejs:8.x

EXPOSE 2525
CMD ["start"]
RUN npm install -g mountebank --production
ENTRYPOINT ["mb"]




Construir una imagen a partir de un archivo Dockerfile
 * docker build -t <IMAGE_NAME> -f Dockerfile
  Ejemplo: docker build -t org.example/nodejs/myapp -f Dockerfile.myapp

Ejecutar un contenedor
 * docker container run --rm <IMAGE_NAME>
   Ejemplo: docker container run --rm org.example/nodejs/myapp

Acceder a la instancia del contenedor Docker
 * docker container exec -it <CONTAINER_ID> bash
   Ejemplo: docker container exec -it fa4ea442aeb bash

Listar imagenes Docker
 * docker images

Listar contenedores Docker
 * docker ps -a

Remover una imagen
 * docker rmi org.example/nodejs/myapp

Remover todas las imagenes
 * docker image prune -a

Remover un container Docker
 * docker rm -f <CONTAINER_ID>
   Ejemplo: docker rm -f fa4ea442aeb

<h1>Amazon AWS ECS/ECR</h1>

Obtener credenciales para acceder a Docker en ECR AWS
 * aws ecr get-login --region us-east-1 --no-include-email

 * docker login -u AWS -p <PASSWORD> http://<AWS_INSTANCE>

Tagear la imagen de Docker con el nombre del repositorio completo de ECR-AWS
 * docker tag <AWS_INSTANCE>/<DOMAIN>/<REPOSITORY_NAME> 
   Ejemplo: 08789734324.dkr.ecr.us-east-1.amazonaws.com/org.example/nodejs:8.x

Subir la imagen al ECR-AWS
 * docker push <AWS_INSTANCE>/<DOMAIN>/<REPOSITORY_NAME> 
   Ejemplo: 08789734324.dkr.ecr.us-east-1.amazonaws.com/org.example/nodejs:8.x

Prueba de ejecución de imagen Docker
 * docker container run -rm -p <hostPort>:<containerPort> <AWS_INSTANCE>/<DOMAIN>/<REPOSITORY_NAME>
   Ejemplo: container run -rm -p <8080>:<8080> 08789734324.dkr.ecr.us-east-1.amazonaws.com/org.example/nodejs:8.x


<h1>Terraform</h1>
https://www.terraform.io

Crear una infraestructura en AWS utilizando Terraform

Inicialización de projecto Terraform
 * terraform init

Ejecutar un plan
 * terraform plan

Aplicar los cambios a la infraestructura
 * terraform apply -auto-approve
 * terraform apply -auto-approve -target="module.modulename.aws_resource.arm" 
 Ejemplo: terraform apply -auto-approve -target="module.repositories.aws_ecr_resource.shared_state"
 
Destruir la infraestructura creada
 * terraform destroy -auto-approve
 * terraform destroy -target="aws_element.name"
   Ejemplo: terraform destroy -target="aws_ecs_service.login_service"

Mostrar elemtos configurados
 * terraform show   
