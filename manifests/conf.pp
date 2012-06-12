define git::conf($ensure=present) {

#	common::concatfilepart {"repo-${name}":
#    	ensure  => $ensure,
#    	file    => "/home/git/gitolite-admin/conf/gitolite.conf",
#    	content => template("git/default-repo.erb"),
#  	}

common::concatenated_file_part { "/tmp/files/${name}" :
	 dir => "/tmp/files/",
	 content => template("git/default-repo.erb"),
	} ->
  	common::concatenated_file { "/tmp/gitolite.conf" :
  		dir => "/tmp/files/",
  		header => "/tmp/header.txt",
  	}
}