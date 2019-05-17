
Acceder a la instancia del contenedor Docker
 * docker container exec -it <CONTAINER_ID> bash
   Ejemplo: docker container exec -it fa4ea442aeb bash

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


Infraestructura AWS

Crear una infraestructura en AWS utilizando Terraform


Ejecutar un plan
 * terraform plan

Aplicar los cambios a la infraestructura
 * terraform apply -auto-approve

Destruir la infraestructura creada
 * terraform destroy -auto-approve
 * terraform destroy -target="aws_element.name"
   Ejemplo: terraform destroy -target="aws_ecs_service.login_service"
