// Copies current JIRA board info in comma-delineated format for easy manipulation in Google Sheets
copy(
  Object.values(document.querySelectorAll("div.ghx-issue-content")).map(
    container => {
      const typeElem = container.querySelector("span.ghx-type.items-spacer");
      const type = typeElem ? typeElem.title : null;

      const titleElem = container.querySelector(
        "div.ghx-summary span.ghx-inner"
      );
      const title = titleElem ? titleElem.innerText : null;

      const rowEndContainer = container.querySelector(
        "div.ghx-row.ghx-end.ghx-items-container"
      );

      const epicElem = rowEndContainer
        ? rowEndContainer.querySelector("span[data-epickey]")
        : null;
      const epicName = epicElem ? epicElem.innerText : null;
      const epicKey = epicElem
        ? epicElem.dataset && epicElem.dataset.epickey
        : null;

      const ticketNumElem = rowEndContainer
        ? rowEndContainer.querySelector("a.ghx-key.js-key-link")
        : null;
      const ticketNum = ticketNumElem ? ticketNumElem.title : null;
      const ticketNumLink = ticketNumElem ? ticketNumElem.href : null;

      const priorityElem = rowEndContainer
        ? rowEndContainer.querySelector("span.ghx-priority")
        : null;
      const priority = priorityElem ? priorityElem.title : null;

      const storyPointElem = rowEndContainer
        ? rowEndContainer.querySelector('span[title="Story Points"]')
        : null;
      const storyPoints = storyPointElem ? storyPointElem.innerText : null;

      return [
        type,
        title,
        epicName,
        epicKey,
        ticketNum,
        ticketNumLink,
        priority,
        storyPoints
      ].join(", ");
    }
  )
);
