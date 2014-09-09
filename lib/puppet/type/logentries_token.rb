Puppet::Type.newtype(:logentries_token) do
  @doc = %q{ Reperesents a single logentries token used in
language specific logging.

    Example:

  logentries::token { "python_log":
      ensure            => present,
      account_key       => 'long-key-from-logentries'
  }
  }
  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam :name do
    desc "The name of the package"
  end
  newparam :account_key do
    desc "Get this key from logentries."
  end
  newparam :host_key do
    desc "The host key (or agent-key) from logentries."
  end
end
