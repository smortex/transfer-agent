metadata :name => "transfer",
         :description => "Transfer files between hosts",
         :author => "Romain Tartiere",
         :license => "MIT",
         :version => "1.0.0",
         :url => "https://github.com/smortex/tranfer-agent",
         :timeout => 10

action "push", :description => "Push a file to remove hosts" do
  input :file,
        :prompt => "File",
        :description => "File to manage",
        :type => :string,
        :validation => :shellsafe,
        :optional => false,
        :maxlength => 255

  input :content,
        :prompt => "Content",
        :description => "Content to write to the file",
        :type => :string,
        :validation => '.*',
        :optional => false,
        :maxlength => 16384

  input :user,
        :prompt => "User",
        :description => "User of the file",
        :type => :string,
        :validation => '\A[[:alnum:]]+\z',
        :optional => false,
        :default => 'root',
        :maxlength => 255

  input :group,
        :prompt => "Group",
        :description => "Group of the file",
        :type => :string,
        :validation => '\A[[:alnum:]]+\z',
        :optional => false,
        :default => 'wheel',
        :maxlength => 255

  input :mode,
        :prompt => "Mode",
        :description => "Mode of the file",
        :type => :string,
        :validation => '\A[[:digit:]]{3}\z',
        :optional => false,
        :default => '644',
        :maxlength => 3
end
