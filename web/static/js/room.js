let Room = {
  channel: null,
  channelName: "",
  element: null,
  messages: [],
  name: "",
  socket: null,
  init(element, socket) {
    this.element = element;

    this.name = element.dataset["name"];

    this.socket = socket;

    this.socket.connect();

    this.channelName = `rooms:${this.name}`;

    this.channel = this.socket.channel(this.channelName);

    const messagesContainer = this.element.querySelector(".messages");

    this.channel.on("new_message", (response) => {
      this.messages.push(response);

      if (messagesContainer) {
        const messageTimestamp = (new Date(Date.parse(response.at))).toLocaleString();

        let messageContainer = document.createElement("div");

        messageContainer.classList.add("message", "col-sm-12");

        messageContainer.appendChild(document.createTextNode(`${response.user_token.slice(0, 8)} (${messageTimestamp}): ${response.body}`));

        messagesContainer.appendChild(messageContainer);
      }
    });

    this.channel.join()
      .receive("ok", response => console.log("joined the room channel", response))
      .receive("error", reason => console.log("join failed", reason));

    const newMessageTextInput = this.element.querySelector(".new-message-text-input");

    const newMessageSubmitButton = this.element.querySelector(".new-message-submit-button");

    if (newMessageTextInput && newMessageSubmitButton) {
      const submitNewMessage = (event) => {
        event.preventDefault();

        const newMessage = newMessageTextInput.value;

        if (newMessage) {
          const payload = {
            body: newMessage
          };

          this.channel.push("new_message", payload).
            receive("error", error => console.log(error));

          newMessageTextInput.value = "";
        }
      };

      newMessageSubmitButton.addEventListener("click", submitNewMessage, false);

      newMessageTextInput.addEventListener("keyup", function(event) {
        if (event.keyCode === 13) {
          submitNewMessage(event);
        }
      }, false);
    }
  }
};

export default Room;
