load("render.star", "render")
load("http.star", "http")
load("encoding/base64.star", "base64")

birthdays = {
    "01-01": [
        {
            "name": "Portgas D. Ace",
            "image": "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"
        },
    ],
    "05-05": [
        {
            "name": "Monkey D. Luffy",
            "image": "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"
        },
    ]
}


def main(config):
    CHARACTER_PIC = base64.decode(birthdays["01-01"][0]["image"])
    return render.Root(
        child = render.Row(
            children = [
                render.Image(src=CHARACTER_PIC)
            ],
        ),
    )