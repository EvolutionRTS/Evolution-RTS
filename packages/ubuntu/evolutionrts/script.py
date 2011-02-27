#!/usr/bin/env python
# build debian package for a given set of distro series
# easy_install {python-debian,pytz}
import debian.changelog as dch
import datetime, pytz,shutil, sys, traceback,subprocess,os
changelog_fn = 'debian/changelog' 
try:
	with open(changelog_fn):
		pass
except:
	print './%s not found, run this script from within the package dir'%changelog_fn
	sys.exit(-1)
	
version = '0.0.1'
urgency = 'low'
package = 'evolutionrts'
author = 'Rene Milk <koshi@springobby.info>'
ppa_rev = 2
key = '7060A4D8'
ppa_name = 'evorts/testing'
date = datetime.datetime.now( pytz.timezone('Europe/Berlin') ).strftime( '%a, %d %b %Y %H:%M:%S %z')
distros = [  ['karmic','9.10'], ['lucid','10.04'], ['maverick','10.10'],['natty','11.04'] ]
#distros = [  ['karmic','9.10'] ]

def run(arglist):
	p = subprocess.Popen(
			arglist,
			stdin=subprocess.PIPE,
			stdout=subprocess.PIPE,
			stderr=subprocess.PIPE)
	return p.communicate()
		
backup_fn = '../changelog~'
shutil.copy2( changelog_fn, backup_fn )
try:
	for distro in distros:
		#get unmodified changelog to not pollute it with one change per series
		shutil.copy2( backup_fn, changelog_fn )
		changelog  = dch.Changelog( open(changelog_fn) )
		distro_version = '%s~%s~ppa%d'%(version,distro[1],ppa_rev)
		changelog.new_block( package=package, version=distro_version, distributions=distro[0], urgency=urgency, author=author, date=date )
		changelog.add_change( '' )
		changelog.add_change( '  * New upstream release' )
		changelog.add_change( '' )

		with open( changelog_fn, 'wb' ) as new_changelog:
			changelog.write_to_open_file( new_changelog )
		
		out,err = run( ['debuild', '-S', '-sa', '-k%s'%key] )
		if err != '':
			raise Exception( str(out, err) )
			
	args = ['dput', 'ppa:%s'%ppa_name]
	changes_files = [os.path.join('..', file) for file in os.listdir('..') if file.lower().endswith('changes')]
	args += changes_files
	print args
	out,err = run( args )
	print out, err 
except Exception,m:
	print 'script failed with:'
	print str(m)
	traceback.print_exc()
	shutil.copy2( backup_fn, changelog_fn )
