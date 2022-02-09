from oct2py import Oct2Py
import os, shutil
import threading


def start_octave_process(from_arg, to_arg):
    oc = Oct2Py()
    oc.feval('./maininterface.m', 'AIDS', None, None)


if __name__ == '__main__':
    if not os.path.isdir('./output'):
        os.mkdir('./output')
    print('Thread Creation started...')
    t1 = threading.Thread(target=start_octave_process, args=(3, 6,))
    # t2 = threading.Thread(target=start_octave_process, args=(5, 5,))
    # t3 = threading.Thread(target=start_octave_process, args=(6, 6,))
    print('Thread Creation End...')

    print('First T started...')
    t1.start()
    # print('Second T started...')
    # t2.start()
    # print('Third T started...')
    # t3.start()
    #
    # t1.join()
    # t2.join()
    # t3.join()

    print('Done!')
