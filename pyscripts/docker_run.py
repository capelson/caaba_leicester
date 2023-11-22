import docker
import os
import multiprocessing
import time
# Initialize the Docker client
# client = docker.from_env()

# # Run 10 containers and copy files
# for i in range(1, 2):
#     # Create and start a container
#     container = client.containers.run('caaba_delhi', detach=True, name=f'my_container_{i}', command='xcaaba caaba_delhi.ini')
#     exit_code = container.wait()
    
#     if exit_code['StatusCode'] == 0:
#          # Copy a file from the container to your local machine
#         source_path = f'/caaba/output'
#         local_path = f'/home/taras/Work'
    
#         os.system(f'docker cp -a my_container_{i}:{source_path} {local_path}')

#         container.remove()
#     else:
#         print(f'Container my_container_{i} has finished with an error (exit code {exit_code["StatusCode"]}).')

   
    
#     # Remove the container
#     #container.remove()

# # Close the Docker client
# client.close()


def run_container_and_copy_files(container_name, image_name, source_path, local_path):
    client = docker.from_env()
    
    # Create and start a container
    container = client.containers.run(image_name, detach=True, name=container_name, command='xcaaba caaba_delhi.ini')
    
    # Wait for the container to finish
    exit_code = container.wait()
    
    if exit_code['StatusCode'] == 0:
    
        os.system(f'docker cp -a {container_name}:{source_path} {local_path}')

        container.remove()
    else:
        print(f'Container {container_name} has finished with an error (exit code {exit_code["StatusCode"]}).')
    
    # Remove the container
    client.close()


if __name__ == '__main__':
    # List of container information
    containers_info = [
        {
            'name': 'my_container_1',
            'image': 'caaba_delhi',
            'source_path': '/caaba/output',
            'local_path': '/home/taras/Work'
        },
        # Add information for other containers here
        {
            'name': 'my_container_2',
            'image': 'caaba_delhi',
            'source_path': '/caaba/ini',
            'local_path': '/home/taras/Work'
        },
        {
            'name': 'my_container_3',
            'image': 'caaba_delhi',
            'source_path': '/caaba/output',
            'local_path': '/home/taras/Work/garbage'
        },
        # Add information for other containers here
        {
            'name': 'my_container_4',
            'image': 'caaba_delhi',
            'source_path': '/caaba/ini',
            'local_path': '/home/taras/Work/garbage'
        },
              {
            'name': 'my_container_5',
            'image': 'caaba_delhi',
            'source_path': '/caaba/output',
            'local_path': '/home/taras/Work/garbage'
        },
        # Add information for other containers here
        {
            'name': 'my_container_6',
            'image': 'caaba_delhi',
            'source_path': '/caaba/ini',
            'local_path': '/home/taras/Work/garbage'
        }
    ]

    # Run containers and copy files in parallel
    with multiprocessing.Pool() as pool:
        start_time = time.time()
        pool.starmap(run_container_and_copy_files, [(info['name'], info['image'], info['source_path'], info['local_path']) for info in containers_info])
        print("My program took", time.time() - start_time, "to run")