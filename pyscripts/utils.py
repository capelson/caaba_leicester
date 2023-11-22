from datetime import date, timedelta
import math
def parse_nml(template_path, save_path, species_file='input/default_delhi_init_spec.nc', **params):
    with open(template_path, 'r') as template_file:
        template_file_data = template_file.read()

    def insert_param(placeholder, param, file):
        if placeholder in file:
            file = file.replace(placeholder, str(param))
        else:
            print(f'Parameter {placeholder} not in file')
        return file
	
    template_file_data = insert_param('{press}', params['press'], template_file_data)
    template_file_data = insert_param('{temp}', params['temp'], template_file_data)
    template_file_data = insert_param('{relhum}', params['relhum'], template_file_data)
    template_file_data = insert_param('{zmbl}', params['zmbl'], template_file_data)
    template_file_data = insert_param('{lat}', params['lat'], template_file_data)
    template_file_data = insert_param('{lon}', params['lon'], template_file_data)
    template_file_data = insert_param('{model_start_day}', params['model_start_day'], template_file_data)
    template_file_data = insert_param('{runtime_str}', params['runtime_str'], template_file_data)
    template_file_data = insert_param('{time_step}', params['time_step'], template_file_data)
    template_file_data = insert_param('{species_file}', species_file, template_file_data)

    try:
        with open(save_path, 'x') as file:
            file.write(template_file_data)
    except FileExistsError:
        with open(save_path, 'w') as file:
            file.write(template_file_data)

def pass_param_to_ini_file(template_path, output_file, **params):
    with open(template_path, 'r') as template_file:
        template_file_data = template_file.read()

    def insert_param(placeholder, param, file):
        if placeholder in file:
            file = file.replace(placeholder, str(param))
        else:
            print(f'Parameter {placeholder} not in file')
        return file
	
    template_file_data = insert_param('{meccainifile}', params['meccainifile'], template_file_data)
    template_file_data = insert_param('{compile}', params['compile'], template_file_data)
    template_file_data = insert_param('{nmlfile}', params['nmlfile'], template_file_data)
    template_file_data = insert_param('{l_montecarlo}', params['l_montecarlo'], template_file_data)
    template_file_data = insert_param('{runcaaba}', params['runcaaba'], template_file_data)
    template_file_data = insert_param('{outputdir}', params['outputdir'], template_file_data)
    template_file_data = insert_param('{l_caabaplot}', params['l_caabaplot'], template_file_data)

    try:
        with open(output_file, 'x') as file:
            file.write(template_file_data)
    except FileExistsError:
        with open(output_file, 'w') as file:
            file.write(template_file_data)

def get_month_by_ord_day(days, year=2019):
    ref_date = date(year, 1, 1) 
    delta = timedelta(int(math.floor(days))) 
    newdate = ref_date + delta
    return newdate.strftime("%B")