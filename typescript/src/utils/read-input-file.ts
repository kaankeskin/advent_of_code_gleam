import {join} from 'path';
import {readFile} from 'node:fs/promises';

type YearAndDay = {year: number; day: number};

export class ReadInputFile {
  private inputDir: string;
  private yearAndDay?: YearAndDay;

  constructor(inputDataDirectoryPath: string) {
    this.inputDir = inputDataDirectoryPath;

    if (!this.inputDir) {
      throw new Error('Input data directory path must be provided.');
    }
  }

  setDate(year: number, day: number): ReadInputFile {
    this.yearAndDay = {year, day};
    return this;
  }

  private readFileWithSuffix(suffix = ''): Promise<string> {
    if (
      this.yearAndDay === undefined ||
      this.yearAndDay.year === undefined ||
      this.yearAndDay.day === undefined
    ) {
      throw new Error('Year and day must be set. Use `.setDate()` first.');
    }

    return readFile(
      join(
        this.inputDir,
        `${this.yearAndDay.year}`,
        `${this.yearAndDay.day}${suffix}.txt`,
      ),
      {
        encoding: 'utf8',
      },
    );
  }

  async readExampleFile(): Promise<string> {
    try {
      return await this.readFileWithSuffix('.example');
    } catch (error) {
      if (error instanceof Error) {
        if ((error as {code?: string}).code === 'ENOENT') {
          throw new Error("Can't read puzzle example inupt file.");
        }
      }
      throw error;
    }
  }

  async readInputFile(): Promise<string> {
    try {
      return await this.readFileWithSuffix();
    } catch (error) {
      if (error instanceof Error) {
        if ((error as {code?: string}).code === 'ENOENT') {
          throw new Error("Can't read puzzle inupt file.");
        }
      }
      throw error;
    }
  }
}
