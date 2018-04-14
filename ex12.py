import PIL
import scipy
import numpy as np
from scipy.io import loadmat
from scipy.io import savemat
from PIL import Image
from numpy import array
import matplotlib.pyplot as plt
import sys
import Image

caffe_root = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/'
sys.path.insert(0, caffe_root + 'python')
import caffe

from caffe.proto import caffe_pb2
import time

caffe.set_mode_gpu()

net=caffe.Classifier('/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/NiN/deploy.prototxt','/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/NiN/nin_imagenet_conv.caffemodel',raw_scale=(255),channel_swap=(2,1,0))

# input preprocessing: 'data' is the name of the input blob == net.inputs[0]
blob = caffe.proto.caffe_pb2.BlobProto()
data = open( caffe_root+'data/ilsvrc12/imagenet_mean.binaryproto' , 'rb' ).read()
blob.ParseFromString(data)
m=np.array( caffe.io.blobproto_to_array(blob) )
#m=np.ndarray.reshape(m,3,256,256)
#net.set_mean('data', m)  # ImageNet mean
#net.set_raw_scale('data', 255)  # the reference model operates on images in [0,255] range instead of [0,1]
#net.set_channel_swap('data', (2,1,0))  # the reference model has channels in BGR order instead of RGB

#cat = sys.argv[1]
a300=[]
a300.insert(1,'flyingbird')
a300.insert(2,'horse')
print a300
a200=[]
a200.insert(1,'alternate')
a200.insert(2,'length')
a200.insert(3,'temporal')
a200.insert(4,'saliencytype1')
a200.insert(5,'saliencytype2')
a200.insert(6,'randomorder')
for p2,elem3 in enumerate(a300): 
 a100=[]
 cat=elem3
 groundtruth_file='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/groundtruth/%s.txt' % (cat)
 g_paths=open(groundtruth_file,'r')
 groundtruths=g_paths.read().splitlines()
 for p1,elem2 in enumerate(groundtruths):
  a100.insert(p1,int(elem2)) 
#sch1 = sys.argv[2]
#sch2 = sys.argv[3]
 for p3,elem4 in enumerate(a200):
  sch1=elem4
  sch2='without_context'
  paths_file='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/addresses1/%s/%s/%s.txt' % (cat,sch1,sch2)
  #print paths_file
  #print paths_file
  f_paths = open(paths_file,'r')
  
  line_paths = f_paths.read().splitlines()
  output_path='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/results1/%s/%s/%s.txt' % (cat,sch1,sch2)
  print output_path
  file1=open(output_path,'w')
#i=0;
  for elem1 in line_paths:
    img_path  = elem1
    #i=i+1
    img = caffe.io.load_image(img_path)    
    #print img_path
    imgE = np.ndarray(shape=(1,img.shape[0],img.shape[1],img.shape[2]), dtype=np.float64)
    imgE[0,:,:,:] = img
    scores = net.predict(imgE,oversample=False)
    numrows=len(scores)
    numcols=len(scores[0])
    #print numrows
    #print numcols
    m=max(scores[0])
    for i,j in enumerate(scores[0]):
      if j==m:
       a95=i
       
       if a95 in a100:
         #input(' ');
         print a95 , 1
         h=1
       else:
         print a95 , 0
         h=0
       file1.write("%d,%d"%(a95,h))
       file1.write("\n")
       #print u9999
  file1.close()
  f_paths.close()
  g_paths.close()
  sch2='with_context'
  paths_file='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/addresses1/%s/%s/%s.txt' % (cat,sch1,sch2)
#print paths_file
  f_paths = open(paths_file,'r')
  line_paths = f_paths.read().splitlines()
  output_path='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/results1/%s/%s/%s.txt' % (cat,sch1,sch2)
  print output_path
  file1=open(output_path,'w')
#i=0;
  for elem1 in line_paths:
    img_path  = elem1
    #i=i+1
    img = caffe.io.load_image(img_path)    
    #print img_path
    imgE = np.ndarray(shape=(1,img.shape[0],img.shape[1],img.shape[2]), dtype=np.float64)
    imgE[0,:,:,:] = img
    scores = net.predict(imgE,oversample=False)
    numrows=len(scores)
    numcols=len(scores[0])
    #print numrows
    #print numcols
    m=max(scores[0])
    for i,j in enumerate(scores[0]):
      if j==m:
       a95=i
       
       if a95 in a100:
         #input(' ');
         print a95 , 1
         h=1
       else:
         print a95 , 0
         h=0
       file1.write("%d,%d"%(a95,h))
       file1.write("\n")
  file1.close()
  f_paths.close()
  g_paths.close()
  sch2='blurcontext1'
  paths_file='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/addresses1/%s/%s/%s.txt' % (cat,sch1,sch2)
#print paths_file
  f_paths = open(paths_file,'r')
  line_paths = f_paths.read().splitlines()
  output_path='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/results1/%s/%s/%s.txt' % (cat,sch1,sch2)
  print output_path
  file1=open(output_path,'w')
#i=0;
  for elem1 in line_paths:
    img_path  = elem1
    #i=i+1
    img = caffe.io.load_image(img_path)    
    #print img_path
    imgE = np.ndarray(shape=(1,img.shape[0],img.shape[1],img.shape[2]), dtype=np.float64)
    imgE[0,:,:,:] = img
    scores = net.predict(imgE,oversample=False)
    numrows=len(scores)
    numcols=len(scores[0])
    #print numrows
    #print numcols
    m=max(scores[0])
    for i,j in enumerate(scores[0]):
      if j==m:
       a95=i
       
       if a95 in a100:
         #input(' ');
         print a95 , 1
         h=1
       else:
         print a95 , 0
         h=0
       file1.write("%d,%d"%(a95,h))
       file1.write("\n")
  file1.close()
  f_paths.close()
  g_paths.close()
  sch2='blurcontext2'
  paths_file='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/addresses1/%s/%s/%s.txt' % (cat,sch1,sch2)
#print paths_file
  f_paths = open(paths_file,'r')
  line_paths = f_paths.read().splitlines()
  output_path='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/results1/%s/%s/%s.txt' % (cat,sch1,sch2)
  print output_path
  file1=open(output_path,'w')
#i=0;
  for elem1 in line_paths:
    img_path  = elem1
    #i=i+1
    img = caffe.io.load_image(img_path)    
    #print img_path
    imgE = np.ndarray(shape=(1,img.shape[0],img.shape[1],img.shape[2]), dtype=np.float64)
    imgE[0,:,:,:] = img
    scores = net.predict(imgE,oversample=False)
    numrows=len(scores)
    numcols=len(scores[0])
    #print numrows
    #print numcols
    m=max(scores[0])
    for i,j in enumerate(scores[0]):
      if j==m:
       a95=i
       
       if a95 in a100:
         #input(' ');
         print a95 , 1
         h=1
       else:
         print a95 , 0
         h=0
       file1.write("%d,%d"%(a95,h))
       file1.write("\n")
       
  file1.close()
  f_paths.close()
  g_paths.close()
