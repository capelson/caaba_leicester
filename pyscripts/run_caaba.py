from netCDF4 import Dataset
import os
import time
from utils import pass_param_to_ini_file, parse_nml, get_month_by_ord_day
WORKDIR = os.getcwd()

params = {}
params['temp'] = os.getenv('TEMP')
params['press'] = os.getenv('PRESS')
params['relhum'] = os.getenv('RH')
params['start_day'] = os.getenv('DAY')
params['level'] = os.getenv('LEVEL')
params['lat'] = os.getenv('LAT')
params['lon'] = os.getenv('LON')
params['species_file'] = os.getenv('SPEC_FILE')

levels_by_1km =  {7: 1,
 13: 2,
 17: 3,
 19: 4,
 21: 5,
 23: 6,
 25: 7,
 26: 8,
 27: 9,
 28: 10,
 29: 11,
 30: 12,
 31: 13,
 32: 14,
 33: 15,
 34: 16,
 35: 17,
 36: 18,
 37: 19,
 38: 20}

def run_caaba(input_params, levels_vs_kms=levels_by_1km):
    start_day = input_params['start_day']
    lat = input_params['lat']
    level = input_params['level']
    lon = input_params['lon']
    temp = input_params['temp']
    press = input_params['press']
    relhum = input_params['relhum']
    species_file = input_params['species_file']

    if levels_vs_kms[int(level)] > 1:

        parse_nml(
            WORKDIR+"/templates/caaba_delhi_teplate.nml",
            WORKDIR+"/nml/caaba_example.nml",
            species_file=species_file,
            model_start_day=float(start_day),
            runtime_str="5 days",
            time_step="5 minutes",
            press=float(press),
            temp=float(temp),
            relhum=float(relhum),
            zmbl=1000,
            lat=float(lat),
            lon=float(lon)
        )
    else:
        parse_nml(
            WORKDIR+"/templates/caaba_delhi_teplate.nml",
            WORKDIR+"/nml/caaba_example.nml",
            species_file=species_file,
            model_start_day=float(start_day), 
            runtime_str="5 days",
            time_step="5 minutes",
            press=100366,
            temp=278.15,
            relhum=0.90,
            zmbl=1000,
            lat=float(lat),
            lon=float(lon)
        )


    dir_name = "LAT_{}_LON_{}_{}_{}km".format(lat, lon, get_month_by_ord_day(float(start_day)), levels_vs_kms[int(level)])
    print(dir_name)
    params = {
    'meccainifile':'example',
    'compile':'s',
    'nmlfile':'caaba_example.nml',
    'l_montecarlo':'False',
    'runcaaba':'y',
    'outputdir':dir_name,
    'l_caabaplot':'False'
    } 
    pass_param_to_ini_file(template_path=WORKDIR+"/templates/ini_template.ini",
                      output_file=WORKDIR+"/ini/example.ini", **params)
    
    os.system("./xcaaba example.ini")

if __name__ == '__main__':
    run_caaba(params)

