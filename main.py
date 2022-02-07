from oct2py import Oct2Py
import os, shutil


if __name__ == '__main__':
    oc = Oct2Py()
    if not os.path.isdir('./output'):
        os.mkdir('./output')
    oc.feval(func_path='./maininterface.m')

