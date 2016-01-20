class Heap
  def initialize(vals = [])
    @store = []
    vals.each {|val| insert(val)}
  end

  def peek_min
    @store.first
  end

  def pop_min
    return nil if @store.empty?

    swap!(0, @store[-1])
    min = @store.pop
    heapify_down!

    min
  end

  def swap!(a, b)
    @store[a], @store[b] = @store[b], @store[a]
  end

  def insert(val)
    @store.push(val)
    heapify_up!
  end

  def parent_idx(i)
    i == 0 ? nil : (i-1)/2
  end

  def children_idx(i)
    [2*i + 1, 2*i + 2].select { |idx| idx < @store.length }
  end

  def heapify_up!
    i = @store.length - 1

    while i > 0
      parent = parent_idx(i)
      if @store[i] < @store[parent]
        swap!(i, parent)
        i = parent
      else
        break
      end
    end
  end

  def heapify_down!
    i = 0
    while true
      # small will be @store[idx] here, which is broken - we want the actual idx
      small = children_idx(i).min_by { |idx| @store[idx] }
      break if small.nil?

      if @store[i] > @store[small]
        swap(i, small)
        i = small
      else
        break
      end
    end
  end

end
