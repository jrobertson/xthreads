#!/usr/bin/env ruby

# file: xthreads.rb

class XThreads < Hash

  def initialize()
    @threads = self
  end

  class XThread
  
    attr_reader :state

    def initialize(name, options={}, &blk)
      opts = {interval: 4, loop: true}.merge(options)
      @name = name
      @initialized = true
      @state = :stop

      @thread = Thread.new do 
        puts "#{name} created\n"
        Thread.current['name'] = name
        loop = true
        while loop == true do
          
          if @state == :start then
            blk.call
            @state = :dead
            loop = false if opts[:loop] == false
          else
            puts 'stopped' unless @initialized == true
            @initialized = false
          end 

          Thread.stop if @state == :stop

          sleep opts[:interval]
        end
      end

    end 

    def start
      puts "#{@name} starting ..."
      @state = :start
      @thread.run
    end

    def stop
      puts "'#{@name}' stopping ..."
      @state = :stop
    end

    def kill
      puts 'XThread killed'
      @thread.kill
      @state = :dead
    end
    
    def thread
      @thread
    end
  end

  def create_loop(name, options={}, &blk)
    @threads[name] = XThread.new name,  options, &blk
    @threads[name]
  end

  def create_thread(name, options={}, &blk)
    cleanup
    @threads[name] = XThread.new name, options.merge(interval: 0, loop: false), &blk
    @threads[name]
  end

  private

  # Remove any dead threads
  #
  def cleanup()
    @threads.each do |name, thread| 
      @threads.delete name if thread.state == :dead
    end
  end

end