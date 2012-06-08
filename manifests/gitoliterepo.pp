define git::gitoliterepo($ensure, $key){
	

	common::concatfilepart {"repo-${name}":
    	ensure  => $ensure,
    	file    => "/home/git/gitolite-admin/conf/gitolite.conf",
    	content => template("git/default-repo.erb"),
  }
}