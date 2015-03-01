go_archive   = "/tmp/go-1.3.3.tar.gz"
download_uri = "https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz"
install_dir  = "/opt/go-1.3.3"

execute "install tar file" do
  command "wget #{download_uri} -O #{go_archive}"
  not_if File.exists?(install_dir)
end

directory install_dir do
  owner "root"
  group "root"
  mode  "0755"
end

execute "install go-1.3.3" do
  command   <<-EOC
tar -C #{install_dir} --strip=1 -xzf #{go_archive}
EOC
  not_if File.exists?("#{install_dir}/bin")
end

link "/usr/local/go" do
  to install_dir
end

link "/usr/local/bin/go" do
  to "#{install_dir}/bin/go"
end

file go_archive do
  action  :delete
  only_if File.exists?(install_dir)
end
