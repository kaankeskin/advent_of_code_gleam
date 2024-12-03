import {ReadInputFile} from './utils';
import {solutionDay3Part1} from './day3/solution';

const {INPUT_DATA_DIRECTORY_PATH} = process.env as Record<string, string>;

const inputFile = new ReadInputFile(INPUT_DATA_DIRECTORY_PATH);

solutionDay3Part1(inputFile.setDate(2024, 3));
