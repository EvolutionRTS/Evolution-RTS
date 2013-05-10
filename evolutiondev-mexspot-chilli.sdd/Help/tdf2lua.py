import os
import re
import string
import time



dbg=0 # set to 0 if its too verbose. set to 1 for tons of debugging output


#float paramters, values of these keys will be attempted to be parsed as FLOAT
fp= ["damage","energy","metal","height","reclaimtime",'hitdensity']

#boolean paramters, values of these keys will be attempted to be parsed as BOOL
bp=['blocking','reclaimable','autoreclaimable','upright','destructable','indestructable','flammable','noselect','geothermal','shadtrans','animtrans','animating','nodrawundergrey']

#string params:
sp=['customparams','world','description','object','category','name','collisionvolumetype','featurereclamate','seqnamereclamate','featuredead','seqname','filename','seqnamedie']

#integer params
ip=['footprintx','footprintz']

#vectors of 3 floats:
f3p=['collisionvolumeoffsets','collisionvolumescales']

rootdir='' # specify a dir other than the current dir here. NOTE: remember that \ in a path should be \\ for python not to parse it as escape chars, example: 'I:\\maps\\features'
if rootdir=='':
	rootdir=os.getcwd()
print 'cwd:'
print os.getcwd()

for subdir, dirs, files in os.walk(rootdir):
	
    for file in files:
		if file.find(".tdf")>1:
			if dbg==1:
				print "Opening file: %s" % file
				print subdir
				
			f=open(subdir+'\\'+file, 'r')
			lines=f.readlines()
			f.close()
			luafilename=''
			objname=''
			lf=''
			for line in lines:
				comment=''
				if line.find('//')>-1:
					tmp=line.partition('//')
					if dbg==1:
						print 'Found a comment in line: %s' % line
					comment=tmp[2]
					line=tmp[0]
				 
				if re.search("\[.*\]",line): #then we got the first line!
					objname=line.partition('[')[2]
					objname=objname.rpartition(']')[0]
					if objname != '':
						if dbg==1:
							print 'objname= %s'% objname
						
						if objname.find('-')>-1 or objname.find('+')>-1 :
							print "Warning: object name %s contains disallowed characters (-, +), replacing with _" %objname
							objname=objname.replace('-','_')
							objname=objname.replace('+','_')
						luafilename='%s.lua' % objname
						lf=open(subdir+'\\'+luafilename,'w')
						lf.write('local objectname= \"%s\" \n' %objname)
						lf.write('local featureDef	=	{\n')
						lf.write('\tname\t\t\t= \"%s\",\n' %objname)
				elif line.find('{')>-1:
					if dbg==1:
						print 'found { char in line: %s' % line
				elif line.find('}')>-1:
					if dbg==1:
						print 'Ending file on line: %s' % line
					lf.write('} \n')
					lf.write('return lowerkeys({[objectname] = featureDef}) \n')
					lf.close()
				elif line.find('=')>-1:
					parts=line.partition('=');
					if parts[0]=='' or parts[2]=='':
						print 'Error parsing line : %s ' % line						
					key=parts[0].lstrip()
					key=key.rstrip()
					key=string.lower(key)
					value=parts[2]
					if value.find(';')<0:
						print 'Error, no terminating ; found in tdf file at line: %s   ->Skipping line' % line
						break
					else:
						value=value.rstrip().rstrip(';').lstrip().rstrip()
						
					if key in fp:
						lf.write('\t%s\t\t\t\t=%s,\n' % (key,value))
					elif key in bp:
						i=0
						try:
							i=int(value)
						except ValueError:
							if i=='true':
								i=1
							else:
								i=0
							
						if i==1:
							lf.write('\t%s\t\t\t\t=true,\n' % (key))
						elif i==0:
							lf.write('\t%s\t\t\t\t=false,\n' % (key))
						else :
							print 'Error parsing tdf on a boolean value: %s   -> Value not written!' %line
					elif key in sp:
						if key=='name':
							if value != objname:
								print 'Warning: object name (%s) doesnt match parameter name= %s' %(value,objname)
						lf.write('\t%s\t\t\t\t=\"%s\",\n' % (key,value))
					elif key in ip:
						lf.write('\t%s\t\t\t\t=%s,\n' % (key,value))
					elif key in f3p:
						tmp=string.split(value,' ')
						if len(tmp)>3 or len(tmp)<3:
							print 'Error splitting string into 3 floats on: %s' % line
						else:
							lf.write('\t%s\t\t\t\t={%s, %s, %s},\n' % (key,tmp[0],tmp[1],tmp[2]))
					else:
						print 'Warning: Unknown key in %s   ->still attempting to parse and convert it' % line
						v='';
						try:
							v=str(float(value))
						except ValueError:
							v=value
						
						lf.write('\t%s\t\t\t\t=\"%s\",\n' % (key,v))
				if comment != '':
					try:
						lf.write('-- %s' % comment)
					except ValueError:
						print 'Warning, attempting to write %s comment to a closed file' %comment
					except AttributeError:
						print 'Warning, attempt to write comment to nonexisting file! in line: %s, file= %s' %(line,file)
						

s = raw_input('Done, press ENTER to exit')
time.sleep(5)