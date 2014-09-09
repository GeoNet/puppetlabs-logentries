
Puppet::Type.type(:logentries_token).provide :token do
  desc "Logentries token provider"

  commands :le => 'le2'

  def create
    Puppet.debug "creating"
    begin
      output = le(['token-follow', '--host-key', get_host_key(), '--name', resource[:name]])
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("error creating token -> #{e.inspect}")
      return nil
    end
    Puppet.debug('Created token %s' % output)
  end

  def destroy
    Puppet.debug "destroy"
    begin
      output = le(['rm', "hosts/#{get_host_key}/#{resource[:name]}"])
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("error removing token -> #{e.inspect}")
      return nil
    end
    Puppet.debug(output)
  end

  def exists?
    Puppet.debug "exists"
    begin
      le(['ls', "hosts/#{get_host_key}/#{resource[:name]}"])
      return true
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("error finding token -> #{e.inspect}")
    end
    return false
  end

  def get_host_key
    Puppet.debug "get_host_key"
    if resource[:host_key]
      resource[:host_key]
    else
      begin
        le(['host-key']).chomp
      rescue Puppet::ExecutionFailure => e
        Puppet.debug("error finding host key -> #{e.inspect}")
        return nil
      end
    end
  end

end
#  vim: set ts=2 sw=2 tw=0 et:
