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

# ALEXNET
MODEL_FILE = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/bvlc_alexnet/deploy.prototxt'
PRETRAINED = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/bvlc_alexnet/bvlc_alexnet.caffemodel'

# VGG-19
#MODEL_FILE = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/bvlc_vgg19/deploy.prototxt'
#PRETRAINED = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/bvlc_vgg19/bvlc_vgg19.caffemodel'

# GOOGLENET
#MODEL_FILE = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/bvlc_googlenet/deploy.prototxt'
#PRETRAINED = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/bvlc_googlenet/bvlc_googlenet.caffemodel'

# NiN
#MODEL_FILE = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/NiN/deploy.prototxt'
#PRETRAINED = '/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/caffe-master/models/NiN/nin_imagenet_conv.caffemodel'


caffe.set_mode_gpu()
 
net=caffe.Classifier(MODEL_FILE,PRETRAINED,mean=np.load(caffe_root + 'python/caffe/imagenet/ilsvrc_2012_mean.npy').mean(1).mean(1),channel_swap=(2,1,0),raw_scale=255)



#cat = sys.argv[1]
a300=[]
a300.insert(1,'sheep')
a300.insert(2,'train')
print a300
a200=[]
a200.insert(4,'saliencytype1')
a200.insert(5,'saliencytype2')
a200.insert(6,'saliency_area_normalized_partseq_unweighted')
a200.insert(7,'saliency_area_normalized_partseq_weighted')
a200.insert(8,'randomorder')
for p2,elem3 in enumerate(a300): 
 a100=[]
 cat=elem3
 groundtruth_file='/media/data1/datasets/objectparts/PASCAL-Part/part-labeling-code/groundtruth_corrected/%s.txt' % (cat)
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
    # ind5 = indices corresponding to top-5 prediction scores
    pred_scores = scores[0]
    ind5 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-5:]
    common_ind = [val for val in ind5 if val in a100]
    if not common_ind:
      # none of top-5 predictions match ground truth
      ind1 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-1:]
      file1.write("%d,%d"%(ind1[0],0))
    else:
      # at least one of the top-5 predictions matches ground truth
      file1.write("%d,%d"%(common_ind[0],1))
    file1.write("\n")

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
    # ind5 = indices corresponding to top-5 prediction scores
    pred_scores = scores[0]
    ind5 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-5:]
    common_ind = [val for val in ind5 if val in a100]
    if not common_ind:
      # none of top-5 predictions match ground truth
      ind1 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-1:]
      file1.write("%d,%d"%(ind1[0],0))
    else:
      # at least one of the top-5 predictions matches ground truth
      file1.write("%d,%d"%(common_ind[0],1))
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
    # ind5 = indices corresponding to top-5 prediction scores
    pred_scores = scores[0]
    ind5 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-5:]
    common_ind = [val for val in ind5 if val in a100]
    if not common_ind:
      # none of top-5 predictions match ground truth
      ind1 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-1:]
      file1.write("%d,%d"%(ind1[0],0))
    else:
      # at least one of the top-5 predictions matches ground truth
      file1.write("%d,%d"%(common_ind[0],1))
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
    # ind5 = indices corresponding to top-5 prediction scores
    pred_scores = scores[0]
    ind5 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-5:]
    common_ind = [val for val in ind5 if val in a100]
    if not common_ind:
      # none of top-5 predictions match ground truth
      ind1 = sorted(range(len(pred_scores)), key=lambda i: pred_scores[i])[-1:]
      file1.write("%d,%d"%(ind1[0],0))
    else:
      # at least one of the top-5 predictions matches ground truth
      file1.write("%d,%d"%(common_ind[0],1))
    file1.write("\n")

  file1.close()
  f_paths.close()
  g_paths.close()
