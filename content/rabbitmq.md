+++
date = "2016-03-08T13:33:45+08:00"
draft = true
title = "rabbitmq"

+++
#bindings
http://rubybunny.info/articles/bindings.html

If an AMQP message cannot be routed to any queue (for example, because there are no bindings for the exchange it was published to), it is either dropped or returned to the publisher, depending on the message attributes that the publisher has set.

If an application wants to connect a queue to an exchange, it needs to bind them. The opposite operation is called unbinding.

## binding to a exchanger
- queue.bind(exchange)
- queue.bind("action.update") # exchanger defined explcitly
- 

# http://stackoverflow.com/questions/18418936/rabbitmq-and-relationship-between-channel-and-connection
# http://stackoverflow.com/questions/35509784/difference-between-broker-and-exchange

channel is a virtual connection inside a real connection.
borker is referring to a message system such as rabbitmq.

What is dispatch
# https://www.rabbitmq.com/tutorials/tutorial-two-ruby.html
See 'Fair Dispatch'

Originally, rabbitmq does not check whether consumer ack the message or not. Some times the time of dealing with message is differ form consumers. Using 'prefetch' let rabbitmq sending message only when consumer acked the message.

http://rubybunny.info/articles/queues.html
https://www.rabbitmq.com/tutorials/amqp-concepts.html
https://www.rabbitmq.com/consumer-prefetch.html
http://rubybunny.info/articles/exchanges.html
https://www.rabbitmq.com/tutorials/tutorial-one-ruby.html
