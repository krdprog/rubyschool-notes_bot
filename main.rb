require "telegram/bot"

token = ''

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      begin
        lesson_num = message.text.to_i

        if (1..50).include?(lesson_num)
          lesson_num = format('%02d', lesson_num)

          bot.api.send_message(
            chat_id: message.chat.id,
            text: "Ссылка на конспект урока #{lesson_num}: https://github.com/krdprog/rubyschool-notes/blob/master/one-by-one/lesson-#{lesson_num}.md"
          )
        else
          bot.api.send_message(
            chat_id: message.chat.id,
            text: "Номер урока должен быть от 1 до 50."
          )
        end
      rescue
        bot.logger.info('Not sure what to do.')
      end
    else
      begin
        bot.api.send_message(
          chat_id: message.chat.id,
          text: "Привет, #{message.from.first_name}. Напечатайте номер урока (от 1 до 50) для которого показать конспект."
        )
      rescue
        bot.logger.info('Not sure what to do.')
      end
    end
  end
end
