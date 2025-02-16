# HP_quote_process
Repository containing all the documents used for HelloPrint's assignment of making an automated solution for the quotation process.

## Project Overview

This project aims to develop an automated solution to streamline HelloPrint's quotation process. By leveraging data analysis and machine learning techniques, the solution seeks to provide accurate and efficient price estimations.

## How to use it
A dockerized, ready-to-use PoC is already available [here](https://hp-quote-poc-712168389764.europe-southwest1.run.app). It runs through http API calls, so a software like [Postman](https://www.postman.com/) is needed to try it. It has four endpoints that can be tested:

### 1. `POST` /classify

When passing the `user_text` key with a description of a desired quote as a string, it returns a json object with all the categorized information. Example:

- Input:
    ``` json
    key : user_text
    value: I need a quote for five hundred business cards, rectangular, in a matte finishing
    ```
- Output:
```json
    {
    "status": "success",
    "content": {
        "text": "I need a quote for five hundred business cards, rectangular, in a matte finishing",
        "product": "business card",
        "quantity": 500,
        "material": null,
        "finishing": null,
        "shape": "rectangular",
        "length": null,
        "width": null,
        "height": null
        }
    }   
```
### 2. `POST` /suppliers

Similar to `/classify`, but automatically reads the desired product by the user, and also retrieves the contact of the suppliers that can provide it. Example:

- Input:
    ```json
    key : user_text
    value: I need a quote for five hundred stickers, rectangular, in a matte finishing
```
- Output:
    ```json
    {
    "status": "success",
    "content": {
        "response": {
            "text": "I need a quote for five hundred stickers, rectangular, in a matte finishing",
            "product": "sticker",
            "quantity": 500,
            "material": null,
            "finishing": null,
            "shape": "rectangular",
            "length": null,
            "width": null,
            "height": null
        },
        "suppliers": [
            [
                "Office Supply Co",
                "contact@officesupply.com"
            ],
            [
                "Paper World",
                "orders@paperworld.com"
            ],
            [
                "Creative Solutions",
                "hello@creativesol.com"
            ],
            [
                "Eco Supplies",
                "green@ecosupplies.com"
            ]
        ]}
    }
```
Both `/suppliers` and `/classify`:
- Leave a trace of the LM chain used to monitor the AI model. [This is an example of what's stored](https://smith.langchain.com/public/96040c96-89a8-4291-8b80-03120dd9feaf/r)
- Make a new entry in the `inquiries` table, in a connected SQL database.

### 3. `POST` /best-offer
When given a certain `inquiry_id`, it predicts which is the best offer from the suppliers and shows some of its parameters, in a string. The inquiry_id is searched in the related SQL table, **so it is best to test the endpoint with values ranging 1-20**. Example:

- Input:
```json
    key : inquiry_id
    value: 14
```

- Output:
```json
    {
    "status": "success",
    "content": "The best offer of inquiry 14 is the one by supplier 4, with a normalized cost of 0.43. They can deliver the product in 6 days and the acceptance probability of the quote by the customer is 100.0 %."
    }
```
### 4. `POST` /quote-acceptance
It lets us try the prediction model in which the /best-offer is based on. We have to send a body with the parameters used to train the model as seen below, with the following details:
- `cost_average`: Float values between 0 and 1. Lower is better.
- `cost_price`: Float values between 0 and 1. Lower is better.
- `number_days`: Int values from 1 upwards. Lower is better.
- `distance`: Int values from 1 upwards. Lower is better.
- `quote_performance`: Float values between 0 and 1. Higher is better.
- `supplier_performance`: Float values between 0 and 1. Higher is better.

Example:
- Input:
```json
    {
  "cost_average": 1,
  "cost_price": 1,
  "number_days": 100,
  "distance": 100,
  "quote_performance": 0,
  "supplier_performance": 0
    }
```
- Output:
```json
    {
    "status": "success",
    "acceptance_probability": 0
    }
```

## Repository Structure

- **data/**: Contains datasets used for analysis and model training.
- **media/**: Includes images and media files related to the project.
- **models/**: Stores trained machine learning models.
- **notebooks/**: Jupyter notebooks detailing data exploration and model development.
- **src/**: Source code for data processing, model training, and application logic.
- **app.py**: Main application script to run the solution.
- **requirements.txt**: Lists all Python dependencies required for the project.
- **Dockerfile**: Instructions to build a Docker image for the application.

## Getting Started

### Prerequisites

- Python 3.8 or higher
- [pip](https://pip.pypa.io/en/stable/) package installer
- [Docker](https://www.docker.com/) (optional, for containerization)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/RauGarGom/HP_quote_process.git
   cd HP_quote_process
   ```

2. **Install dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

### Running the Application

To start the application, execute:

```bash
python app.py
```

This will launch the automated quotation solution, which can be accessed locally.

### Using Docker

Alternatively, you can run the application within a Docker container:

1. **Build the Docker image:**

   ```bash
   docker build -t hp_quote_process .
   ```

2. **Run the Docker container:**

   ```bash
   docker run -p 8000:8000 hp_quote_process
   ```

The application will be accessible at `http://localhost:8000`.

### DISCLAIMER
If run locally, the program needs the following environment variables to be input:

LANGCHAIN_API_KEY --> API key for Langchain / Langsmith

LANGCHAIN_TRACING_V2="true"

LANGCHAIN_ENDPOINT="https://api.smith.langchain.com"

GOOGLE_API_KEY --> A correct key for Google's Gemini LLM

DB_HOST --> Host where the SQL is stored

DB_PORT --> Port available for the SQL

DB_NAME --> Database Name

DB_USER --> Main user

DB_PASSWORD --> Password for the main user

If you want to replicate the whole SQL, a backup is found in [/data/sql_backup](/data/sql_backup)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

*Note: This README provides a general overview based on the repository structure and typical project setups. For detailed instructions and specific configurations, please refer to the project's documentation or contact the repository maintainer.*

