To enable a user with privileges for Docker in Linux, you can follow these steps:
1.
Add the user to the docker group using the following command:
~~~bash
sudo usermod -aG docker <username>
~~~

Replace <username> with the actual username of the user you want to add to the docker group.

Log out and log back in to apply the group membership changes.

2.
Verify that the user has been added to the docker group by running the following command:

~~~bash
groups <username>
~~~
This command should display a list of all groups the user belongs to, including the docker group.

2. You can also use
Run the following command to activate the new group membership for the current shell session:
~~~
newgrp docker
~~~

3.

Test that the user can run Docker commands with elevated privileges by running the following command:
~~~bash
docker info
~~~
This command should display information about the Docker daemon, indicating that the user has sufficient privileges to run Docker commands.

Note that adding a user to the docker group grants them the ability to run Docker commands with elevated privileges. Be sure to only add trusted users to this group, as they will be able to perform potentially dangerous operations with Docker.
