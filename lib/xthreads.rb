#!/usr/bin/env ruby

# file: xthreads.rb

class XThreads

  def initialize()
    @threads = {}
  end

  class XThread
    def initialize(name, options={}, &blk)
      opts = {interval: 4}.merge(options)
      @name = name
      @initialized = true
      @start = false

      @thread = Thread.new do 
        puts "#{name} created\n"
        Thread.current['name'] = name; 
        loop do
          
          if @start == true then
            blk.call
          else
            puts 'stopped' unless @initialized == true
            @initialized = false
          end 

          Thread.stop if @start == false 

          sleep opts[:interval]
        end
      end

    end 

    def start
      puts "#{@name} starting ..."
      @start = true
      @thread.run
    end

    def stop
      puts "'#{@name}' stopping ..."
      @start = false      
    end

    def kill
      puts 'XThread killed'
      @thread.kill
    end
  end

  def create_loop(name, options={}, &blk)
    @threads[name] = XThread.new name, options, &blk
    @threads[name]
  end
  
  def list()
    @threads
  end
end
