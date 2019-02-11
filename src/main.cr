require "redis"


def help
  abort "Usage: rsone <stream> [<key>] [<field>]"
  exit 1
end


stream = ARGV[0]? || ""
key = ARGV[1]? || ""
field = ARGV[2]? || ""

help if stream.blank?


redis = Redis.new

# When no key is provided, choose one randomly
#
if key.blank?
  info = redis.xinfo("STREAM", stream)
  keys = %w(first-entry last-entry).map { |attr| info[attr].as(Array).first.as(String).split('-').first.to_i64 }
  key = rand(keys.first..keys.last).to_s
end

# Fetch one entry
#
entries = redis.xrange(stream, key, '+', count: 1).as(Hash)
entry_key = entries.keys.first
entry = entries[entry_key]

# Print result, if multiple fields, print one per field
#
entry.each do |(f, v)|
  if field.blank? || field == f
    STDERR.puts "#{stream} #{entry_key} #{f}"
    puts v
  end
end
